// #IHateMyDAW :)
// VCO with sine, square, saw and triangle outputs as well as frequency modulation and LFOs to modulate parameters
s.boot;
(
SynthDef(\evenVCO, {
	arg mFreqN=220,
	sFreqN=110,
	mDexOffset=1,
	sMultOffset=1,
	siAmp=1,
	saAmp=0,
	trAmp=0,
	sqAmp=0,
	mDexLFOFreq=0.01,
	mDexLFOL=1,
	mDexLFOH=20,
	mDexSelection=0,
	sDex=1,
	mFreqSelection=0,
	sFreqSelection=0,
	mFreqLFOFreq=0.01,
	mFreqLFOL=1,
	mFreqLFOH=200,
	sFreqLFOFreq=0.01,
	sFreqLFOL=1,
	sFreqLFOH=200,
	out=0;
	var carr, modu, mDex, mDexSelect, mFreqSelect, mFreq, sFreqSelect, sFreq;
	mDexSelect = [
		mDexOffset, // mDexSelection=0: No LFO
		SinOsc.kr(mDexLFOFreq).range(mDexLFOL, mDexLFOH) // mDexSelection=1: LFO enabled
	];
	mFreqSelect = [
		mFreqN, // mFreqSelection=0: No LFO
		SinOsc.kr(mFreqLFOFreq).range(mFreqLFOL, mFreqLFOH) // mFreqSelection=1: LFO enabled
	];
		sFreqSelect = [
		sFreqN, // sFreqSelection=0: No LFO
		SinOsc.kr(sFreqLFOFreq).range(sFreqLFOL, sFreqLFOH) // sFreqSelection=1: LFO enabled
	];
	mDex = Select.kr(mDexSelection, mDexSelect);
	mFreq = Select.kr(mFreqSelection, mFreqSelect);
	sFreq = Select.kr(sFreqSelection, sFreqSelect);
	modu = (SinOsc.ar(sFreq) * (mDex * sFreq));
	carr = ((SinOsc.ar(mFreq * sDex + modu) * siAmp) + (Saw.ar(mFreq * sDex + modu) * saAmp) + (LFTri.ar(mFreq * sDex + modu) * trAmp) + (Phasor.ar(mFreq * sDex + modu) * sqAmp));
	Out.ar(out, carr ! 2);
}).add;
)
x=Synth(\evenVCO);
x.set(\mFreqN,220);
x.set(\sFreqN,110);
x.set(\mDexOffset,1);
x.set(\sMultOffset,1);
x.set(\siAmp,1);
x.set(\saAmp,0);
x.set(\trAmp,0);
x.set(\sqAmp,0);
x.set(\mDexLFOFreq,0.01);
x.set(\mDexLFOL,1);
x.set(\mDexLFOH,20);
x.set(\mDexSelection,0);
x.set(\sDex,1);
x.set(\mFreqSelection,0);
x.set(\sFreqSelection,0);
x.set(\mFreqLFOFreq,0.01);
x.set(\mFreqLFOL,1);
x.set(\mFreqLFOH,200);
x.set(\sFreqLFOFreq,0.01);
x.set(\sFreqLFOL,1);
x.set(\sFreqLFOH,200);
