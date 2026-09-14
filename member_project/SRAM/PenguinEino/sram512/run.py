#!/usr/bin/env python3
"""Main entry point for the 512-bit project. Run with --help for commands."""
import argparse
import os
from pathlib import Path
import sys

HERE = Path(__file__).resolve().parent
COMMANDS = {
    'tb': ('open.py', []),
    'circuit': ('open.py', ['--circuit']),
    'digital': ('verify_digital.py', []),
    'analog': ('analog.py', []),
    'layout-check': ('verify_saved_layout.py', []),
    'summary': ('validation_summary.py', []),
    'submission': ('build_submission.py', []),
    'submission-lvs': ('submission_lvs.py', []),
    'full-archive': ('package.py', []),
}

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('command', choices=COMMANDS)
args, extra = parser.parse_known_args()
script, defaults = COMMANDS[args.command]
os.chdir(HERE.parent)
command = [sys.executable, str(HERE/'tools'/script), *defaults, *extra]
reports = {'digital': 'digital', 'layout-check': 'saved_layout_recheck'}
if args.command in reports:
    command = [sys.executable, str(HERE/'tools/evidence.py'),
               '--report', reports[args.command], '--', *command]
os.execv(sys.executable, command)
