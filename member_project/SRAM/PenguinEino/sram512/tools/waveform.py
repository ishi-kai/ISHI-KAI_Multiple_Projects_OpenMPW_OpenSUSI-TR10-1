"""Bounds-checked measurements of sampled transient waveforms (time in ns)."""
import numpy as np


class WaveformError(ValueError):
    pass


def validate_time(t, start=None, stop=None):
    t = np.asarray(t)
    if t.ndim != 1 or len(t) < 2 or not np.isfinite(t).all():
        raise WaveformError('Time axis must contain at least two finite samples.')
    if not (np.diff(t) > 0).all():
        raise WaveformError('Time axis must increase strictly.')
    if start is not None and t[0] > start + 1e-6:
        raise WaveformError(f'Missing waveform start: {t[0]} ns, required {start} ns.')
    if stop is not None and t[-1] < stop - 1e-6:
        raise WaveformError(f'Missing waveform end: {t[-1]} ns, required {stop} ns.')


def sample_window(t, values, start, stop=None):
    stop = start if stop is None else stop
    if not np.isfinite([start, stop]).all() or start > stop:
        raise WaveformError(f'Invalid measurement interval: {start}..{stop} ns.')
    if start < t[0] - 1e-6 or stop > t[-1] + 1e-6:
        raise WaveformError(f'Measurement {start}..{stop} ns outside {t[0]}..{t[-1]} ns.')
    # Include both endpoints even when no simulator sample lands there.
    a, b = np.searchsorted(t, [start, stop], side='left')
    def endpoint(when, index):
        # Only read the adjacent samples. np.interp copies a strided raw-file
        # vector in full, which is prohibitively expensive for large traces.
        if index == 0: return values[0]
        if index == len(t): return values[-1]
        if t[index] == when: return values[index]
        weight=(when-t[index-1])/(t[index]-t[index-1])
        return values[index-1]+weight*(values[index]-values[index-1])
    result = np.concatenate(([endpoint(start,a)], values[a:b], [endpoint(stop,b)]))
    if not np.isfinite(result).all():
        raise WaveformError('Non-finite voltage in measurement interval.')
    return result
