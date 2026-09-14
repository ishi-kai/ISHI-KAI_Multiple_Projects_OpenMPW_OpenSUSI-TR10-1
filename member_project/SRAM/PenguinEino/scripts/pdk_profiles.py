"""Project-local, pinned TR-1um profiles shared by GUI and batch checks."""
from pathlib import Path
import hashlib,json,os,subprocess,xml.etree.ElementTree as ET

ROOT=Path(__file__).resolve().parents[1]
STATE=ROOT/'.pdk'
LOCK=ROOT/'pdk/profiles.lock.json'

def sha256(path):return hashlib.sha256(Path(path).read_bytes()).hexdigest()

def tree_digest(root):
    """Include all PDK files except Git metadata and interpreter caches."""
    h=hashlib.sha256()
    files=[]
    for folder,dirs,names in os.walk(root,followlinks=True):
        dirs[:]=[n for n in dirs if n not in ('.git','__pycache__')]
        files.extend(Path(folder)/n for n in names if not n.endswith('.pyc'))
    for p in sorted(files):
        rel=p.relative_to(root)
        if p.is_file():h.update((rel.as_posix()+'\0'+sha256(p)+'\n').encode())
    return h.hexdigest()

def locked():return json.loads(LOCK.read_text())

def profile_name(explicit=None):
    name=explicit or os.environ.get('SRAM_PDK_PROFILE')
    if not name:
        name=(STATE/'active').read_text().strip() if (STATE/'active').exists() else locked()['default_profile']
    if name not in locked()['profiles']:raise ValueError(f'Unknown PDK profile: {name}')
    return name

def pdk_path(profile=None):
    name=profile_name(profile);path=ROOT/locked()['profiles'][name]['path']
    if not (path/'libs.tech/klayout/tech/drc/run.drc').is_file():
        raise RuntimeError(f'PDK profile {name} is not installed. Run ./scripts/pdk setup')
    return path

def environment(profile=None):
    name=profile_name(profile);path=pdk_path(name)
    env=dict(os.environ,SRAM_PDK_PROFILE=name,PDK_ROOT=str(path.parent),PDK='TR-1um',
             KLAYOUT_HOME=str(STATE/'klayout'/name))
    # A global macro search path can load the other version's TR-1um library.
    env.pop('KLAYOUT_PATH',None)
    return env

def provenance(profile=None):
    name=profile_name(profile);path=pdk_path(name);info=locked()['profiles'][name]
    tech=path/'libs.tech/klayout/tech'
    files=[p for kind in ('drc','lvs') for p in sorted((tech/kind).rglob('*')) if p.is_file()]
    return dict(profile=name,pdk_directory=str(path),locked_revision=info.get('revision'),
                rule_sha256={str(p.relative_to(path)):sha256(p) for p in files})

def prepare_gui(profile):
    """Copy user preferences; redirect only the private copy's TR-1um tech."""
    path=pdk_path(profile);home=STATE/'klayout'/profile;home.mkdir(parents=True,exist_ok=True)
    config=home/'klayoutrc'
    if not config.exists():
        backup=STATE/'original-klayoutrc'
        root=ET.parse(backup).getroot() if backup.exists() else ET.Element('config')
        node=root.find('technology-data')
        technologies=ET.fromstring(node.text) if node is not None and node.text else ET.Element('technologies')
        for old in list(technologies):
            if old.findtext('name')=='TR-1um':technologies.remove(old)
        tech=ET.parse(path/'libs.tech/klayout/tech/TR-1um.lyt').getroot()
        for key in ('base-path','original-base-path'):
            item=tech.find(key)
            if item is None:item=ET.SubElement(tech,key)
            item.text=str(path/'libs.tech/klayout/tech')
        technologies.append(tech)
        if node is None:node=ET.SubElement(root,'technology-data')
        node.text=ET.tostring(technologies,encoding='unicode')
        ET.ElementTree(root).write(config,encoding='utf-8',xml_declaration=True)
    macros=home/'pymacros';macros.mkdir(exist_ok=True)
    for source in (ROOT/'klayout/live_drc/pymacros/TR-1um_live_drc.lym',
                   ROOT/'klayout/path_preview/pymacros/path_start_preview.lym'):
        target=macros/source.name
        if not target.exists():target.symlink_to(source)
    return config

def klayout_binary():
    return os.environ.get('SRAM_KLAYOUT_BIN','/home/ishi-kai/bin/klayout/klayout')

def run_drc(source,top,profile=None,output=None):
    import klayout.db as db
    import klayout.rdb as rdb
    import re
    name=profile_name(profile);source=Path(source).resolve()
    layout=db.Layout();layout.read(str(source))
    if layout.cell(top) is None:raise ValueError(f'Cell {top!r} not found in {source}')
    tag=re.sub(r'[^A-Za-z0-9_.-]','_',source.stem+'_'+top)
    out=Path(output).resolve() if output else ROOT/'build/pdk_checks'/name/tag
    out.mkdir(parents=True,exist_ok=True);report=out/'drc.lyrdb';report.unlink(missing_ok=True)
    info=provenance(name);deck=pdk_path(name)/'libs.tech/klayout/tech/drc/run.drc'
    command=[klayout_binary(),'-b','-r',str(deck),'-rd',f'input={source}',
             '-rd',f'top_cell={top}','-rd',f'report={report}']
    result=subprocess.run(command,env={**environment(name),'QT_QPA_PLATFORM':'offscreen'},
                          text=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
    (out/'drc.log').write_text(result.stdout)
    if result.returncode or not report.exists():raise RuntimeError(f'DRC execution failed: {out}/drc.log\n{result.stdout[-1500:]}')
    database=rdb.ReportDatabase();database.load(str(report))
    count=database.num_items()
    record=dict(**info,gds=str(source),gds_sha256=sha256(source),top=top,passed=count==0,items=count,
                categories={c.name():c.num_items() for c in database.each_category() if c.num_items()},
                report=str(report),log=str(out/'drc.log'))
    (out/'result.json').write_text(json.dumps(record,indent=2)+'\n')
    return record
