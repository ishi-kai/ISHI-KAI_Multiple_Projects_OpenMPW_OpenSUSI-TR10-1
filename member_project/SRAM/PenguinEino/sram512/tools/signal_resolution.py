#!/usr/bin/env python3
"""Compare two complete diagnostic reports without conflating convergence and PASS."""
import argparse
from common import *


def compare(first, second, output):
    paths = [Path(first),Path(second)]
    reports = [json.loads(p.read_text()) for p in paths]
    assert all(r['signal_mesh'] and r['access_limit']==1 for r in reports)
    digests = [r['physical_extraction']['gds_sha256'] for r in reports]
    assert len(set(digests))==1
    for key in ('period_ns','voltage_v','temperature_c','maximum_timestep_ns',
                'physical_gate_paths','startup_ramp_ns','solver','integration_method'):
        assert reports[0][key]==reports[1][key],key
    voltage = {}
    for pair in reports[0]['voltage_limits']['maximum_by_pair']:
        observations = [r['voltage_limits']['maximum_by_pair'][pair] for r in reports]
        voltage[pair] = dict(peaks_v=[r['peak_abs_v'] for r in observations],
            difference_v=abs(observations[0]['peak_abs_v']-observations[1]['peak_abs_v']))
    tolerance = .001
    numerical_agreement = all(v['difference_v']<tolerance for v in voltage.values())
    result = dict(passed=all(r['passed'] for r in reports) and numerical_agreement,
        numerical_peak_agreement=numerical_agreement,voltage_peak_tolerance_v=tolerance,
        source_gds_sha256=digests[0],
        reports=[dict(name=p.stem,sha256=sha(p)) for p in paths],
        sections=[r['signal_sections'] for r in reports],
        circuit_passed=[r['passed'] for r in reports],
        failure_counts=[r['failure_count'] for r in reports],
        maximum_mos_voltage_comparison=voltage,
        scope='RC spatial-resolution comparison of two complete first-access diagnostics. Numerical agreement does not imply circuit correctness, and cannot replace the full access sequence.')
    write_json(output,result)
    print(json.dumps(result,indent=2))
    return result


if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('first');p.add_argument('second');p.add_argument('output')
    a=p.parse_args();compare(a.first,a.second,a.output)
