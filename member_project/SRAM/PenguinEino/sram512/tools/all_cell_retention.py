"""Check every physical cell after each operation, including unselected cells.

Power-on data is measured once after RESET has settled; no value is imposed
on the circuit. Each write changes only its target in the expected image.
"""
import numpy as np
from analog import load_raw


def verify(path, case, vdd):
    t, w = load_raw(path)
    return verify_samples(t,w,case,vdd)


def verify_samples(t, w, case, vdd):
    cells = [(r, c) for r in range(16) for c in range(32)]
    operations = case['operations']
    period = case['period_ns']
    initial_time = operations[0]['first'] - .2 * period
    assert initial_time >= case.get('initial_check_ns', .6 * period)
    assert t[-1] >= operations[-1]['e0'] + 7.8 * period
    expected, failures = {}, []
    checks = 0
    locations = {}
    def values(r, c, when):
        if when not in locations:
            k = int(np.searchsorted(t, when, side='right')) - 1
            assert 0 <= k < len(t) - 1
            locations[when] = (k, (when - t[k]) / (t[k+1] - t[k]))
        k, a = locations[when]
        answer = []
        for q in ('q', 'qb'):
            v = w[f'v(xarray.xr{r}c{c}.{q})']
            answer.append(float(v[k] + a * (v[k+1] - v[k])))
        return answer
    for r, c in cells:
        checks += 1
        q, qb = values(r, c, initial_time)
        one = q >= .9 * vdd and qb <= .1 * vdd
        zero = qb >= .9 * vdd and q <= .1 * vdd
        if not (one or zero):
            failures.append(dict(stage='initial_state', cell=[r, c], q_v=q, qb_v=qb))
        expected[r, c] = int(q > qb)
    initial_ones = sum(expected.values())
    for i, op in enumerate(operations):
        target = (op['row'], op['col'])
        if op['write']:
            expected[target] = op['data']
        when = op['e0'] + 7.8 * period
        for r, c in cells:
            q, qb = values(r, c, when)
            for net, value, bit in [('q', q, expected[r, c]), ('qb', qb, 1 - expected[r, c])]:
                checks += 1
                if (value < .9 * vdd if bit else value > .1 * vdd):
                    failures.append(dict(operation=i, cell=[r, c], selected=(r, c) == target,
                                         net=net, expected=bit, voltage_v=value, time_ns=when))
    return dict(passed=not failures, checks=checks, failure_count=len(failures), failures=failures[:40],
        cells=512, operations=len(operations), initial_sample_ns=initial_time,
        initial_ones_observed=initial_ones,
        scope='Observe unspecified initial data after RESET settles, then check Q and QB of every cell after every operation. Only a written target may change. Read-disturb transients inside the WL pulse are not rail-tested by this checker.')
