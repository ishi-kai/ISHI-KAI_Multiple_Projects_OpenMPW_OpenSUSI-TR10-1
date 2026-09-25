"""Diagnostic, algebraically equivalent finite-limit form of dev RR W=2.8 um.

Never edits the installed PDK. The original expression is T*v/(v/R), which
has a removable 0/0 at zero bias. Cancel that pair symbolically to T*R.
Keep every fitted coefficient and PLUS-side capacitance verbatim. This is
NOT a process corner model. Use the unmodified PDK as an independent check.
"""
from pathlib import Path
import re

MODEL=Path('/home/ishi-kai/pdk/TR-1um/libs.tech/spice/models/models_IP62_res_v5.lib')

def definition(scale=1):
 raw=MODEL.read_text()
 branch=raw.split('.elseif (w == 2.8u)',1)[1].split('.endif',1)[0]
 expr=re.search(r"r\s*=\s*'([^']+)'",branch,re.S)[1]
 expr=re.sub(r'\n\s*\+\s*',' ',expr).strip()
 before,after=expr.split('*v(PLUS,MINUS)/',1)
 opening='(v(PLUS,MINUS)/('
 after=after.strip();assert after.startswith(opening) and after.endswith('))')
 middle=after[len(opening):-2]
 result=f'({before})*({middle})*{scale}'
 assert result.count('(')==result.count(')')
 caps=branch[branch.index('c_d0'):].strip()
 return ".subckt F_RR_NUM PLUS MINUS SUB\n.param w=2.8u r=1 l=1u tc1=0 tc2=0 tnom=27\nR0 PLUS MINUS r='"+result+"'\n"+caps+'\n.ends F_RR_NUM\n'

def apply(base,scale=1):
 assert all(float(m[1])==2.8e-6 for m in re.finditer(r'(?im)^\S+\s+\S+\s+\S+\s+\S+\s+F_RR\s+[^\n]*?\bw=([\d.eE+-]+)',base))
 text=re.sub(r'\bF_RR\b','F_RR_NUM',base)
 return re.sub(r'(?im)^\.end\s*$',lambda _:definition(scale)+'\n.end',text)
