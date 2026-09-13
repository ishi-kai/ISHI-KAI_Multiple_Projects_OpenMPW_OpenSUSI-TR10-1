"""Regression tests for the independent review's reproducible checker defects."""
import copy
import unittest
from unittest.mock import patch
import numpy as np
import analog
import evidence
from waveform import WaveformError,validate_time,sample_window
from common import *


class WaveformRegression(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.case=analog.scenario()
        raw=WORK/'analog/pd102_nominal/sram512_tb.raw'
        cls.t,cls.w=analog.load_raw(raw) if raw.exists() else (None,None)

    def setUp(self):
        if self.t is None and self._testMethodName in (
                'test_normal_waveform_passes','test_incomplete_time_span_is_rejected',
                'test_receive_and_write_output_glitches_are_rejected'):
            self.skipTest('Run the pd102_nominal test first; large raw files are not committed.')

    def test_normal_waveform_passes(self):
        self.assertTrue(analog.verify_samples(self.t,self.w,self.case)['passed'])

    def test_incomplete_time_span_is_rejected(self):
        mask=self.t<289000
        self.assertFalse(analog.verify_samples(self.t[mask],
            {n:v[mask] for n,v in self.w.items()},self.case)['passed'])

    def test_receive_and_write_output_glitches_are_rejected(self):
        for start in (2500,14500):
            with self.subTest(start_ns=start):
                w=dict(self.w);sdo=np.array(w['v(sdo)'],copy=True)
                sdo[(self.t>=start)&(self.t<=start+200)]=5;w['v(sdo)']=sdo
                result=analog.verify_samples(self.t,w,self.case)
                self.assertFalse(result['passed'])
                self.assertTrue(any(f.get('net')=='SDO' for f in result['failures']))

    def test_bad_time_axes_are_rejected(self):
        for t in ([0,1,1],[0,2,1],[0,np.nan,2],[0,np.inf,2],[]):
            with self.subTest(t=t),self.assertRaises(WaveformError):validate_time(t)

    def test_measurements_require_both_endpoints(self):
        t=np.array([0.,1.,2.]);v=np.array([0.,5.,0.])
        for start,stop in ((-1,1),(1,3),(-1,None),(3,None)):
            with self.subTest(start=start,stop=stop),self.assertRaises(WaveformError):
                sample_window(t,v,start,stop)
        # An interval between samples still has two interpolated endpoints.
        np.testing.assert_allclose(sample_window(t,v,.2,.8),[1.,4.])


class EvidenceRegression(unittest.TestCase):
    def test_command_that_does_not_write_a_report_cannot_refresh_receipt(self):
        with patch.object(evidence.subprocess,'call',return_value=0):
            with self.assertRaisesRegex(RuntimeError,'did not produce'):
                evidence.run_verified(['digital'],['true'])

    def test_changed_result_is_rejected(self):
        original_sha=evidence.sha
        report=REPORTS/'digital.json'
        def modified_sha(path):
            return 'changed' if Path(path)==report else original_sha(path)
        with patch.object(evidence,'sha',side_effect=modified_sha):
            self.assertFalse(evidence.check('digital')[0])

    def test_changed_circuit_stimulus_and_pdk_invalidate_receipt(self):
        name='digital'
        self.assertTrue(evidence.check(name)[0])
        current=evidence.snapshot(name)
        changes=[('design','sram512/schematics/sram512_bitcell.sch'),
                 ('test_code','sram512/tools/verify_digital.py')]
        for group,path in changes:
            modified=copy.deepcopy(current);modified[group][path]='changed'
            with self.subTest(path=path),patch.object(evidence,'snapshot',return_value=modified):
                self.assertFalse(evidence.check(name)[0])
        modified=copy.deepcopy(current);modified['pdk']['tree_sha256']='changed'
        with patch.object(evidence,'snapshot',return_value=modified):
            self.assertFalse(evidence.check(name)[0])


if __name__=='__main__':unittest.main()
