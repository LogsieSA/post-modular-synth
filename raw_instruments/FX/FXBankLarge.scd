s.boot;
// #IHateMyDAW :)
// Large SoundIn.ar FX bank
(
SynthDef(\fxBank, {
	arg which=0,
	amp=1,
	freqFX=100,
	gain=1.0,
	reset=0,
	reverbRoom=0.5,
	resonance=0.5,
	filterL=600,
	filterH=6000,
	cutoff=1000,
	bits=24,
	rate=44100,
	mix=0.33,
	damp=0.5,
	delay=2.0,
	decay=1.0,
	diff=0.707,
	feedback= 0.0003,
	depth=0.1,
	modFreq=1.0,
	rq=1.0,
	bwr=1.0,
	delayNLC=0,
	combNLC=0,
	allpassNLC=0,
	maxDelay=1.0,
	revtime=3.0,
	damping=0.5,
	inputBW=0.5,
	spread=15,
	dry=0.5,
	earlyReflection=0.7,
	tailLevel=0.5,
	maxRoom=100;
	var in,
	fxNum,
	delaySelection,
	delayFinal,
	combSelection,
	combFinal,
	allpassSelection,
	allpassFinal,
	fOut,
	pIn;


	in = SoundIn.ar(0);
	pIn = in ! 2;
	delaySelection = [
			DelayN.ar(in, maxDelay, delay), //Nested Delay Bank index 0 (delay non-interpolating)
			DelayL.ar(in, maxDelay, delay), //Nested Delay Bank index 1 (delay linear)
			DelayC.ar(in, maxDelay, delay)  //Nested Delay Bank index 2 (delay cubic)
		                ];
	combSelection = [
			CombN.ar(in, maxDelay, delay, decay), //Nested Comb Bank index 0 (Comb non-interpolating)
			CombL.ar(in, maxDelay, delay, decay), //Nested Comb Bank index 1 (Comb linear)
			CombC.ar(in, maxDelay, delay, decay)  //Nested Comb Bank index 2 (Comb cubic)
		                ];
	allpassSelection = [
			AllpassN.ar(in, maxDelay, delay, decay), //Nested Allpass Bank index 0 (Allpass non-interpolating)
			AllpassL.ar(in, maxDelay, delay, decay), //Nested Allpass Bank index 1 (Allpass linear)
			AllpassC.ar(in, maxDelay, delay, decay) //Nested Allpass Bank index 2 (Allpass cubic)
	                    ];

	delayFinal = SelectX.ar(delayNLC, delaySelection) ! 2; // 11 (delayNLC)
	combFinal = SelectX.ar(combNLC, combSelection) ! 2; // 12 (CombNLC)
	allpassFinal = SelectX.ar(allpassNLC, allpassSelection) ! 2; // 13 (Allpass NLC)
	fxNum = [
		pIn, // 0: Pass Through
		MoogFF.ar(in, freqFX, gain, reset) ! 2, // 1: Moog ladder
		RLPF.ar(in, filterL, rq) ! 2, // 2: Low-pass filter
		RHPF.ar(in, filterH, rq) ! 2, // 3: High-pass filter
		Decimator.ar(in, rate, bits) ! 2, // 4: BitCrush
		FreeVerb.ar(in, mix, reverbRoom, damp) ! 2, // 5: Typical reverb
		Greyhole.ar(in, delay, damp, reverbRoom, diff, feedback, depth, modFreq) ! 2, // 6: Big reverb
		BPF.ar(in, freqFX, rq) ! 2, // 7: Band-pass filter
		BRF.ar(in, freqFX, rq) ! 2, // 8: Band reject filter
		Resonz.ar(in, freqFX, bwr) ! 2, // 9: Sharp resonance
		Ringz.ar(in, freqFX, decay) ! 2, // 10: Ringing filter
		delayFinal, // 11: Delay filter selected from delayNLC array
		combFinal, // 12: Comb filter selected from combNLC array
		allpassFinal, // 13: Allpass filter selected from allpassNLC array
		GVerb.ar(in, reverbRoom, revtime, damping, inputBW, spread, dry, earlyReflection, tailLevel, maxRoom) // 14: Massive reverb
	     ];
	fOut = SelectX.ar(which, fxNum);
	fOut = Limiter.ar(fOut, 0.8);
	Out.ar(0, fOut * amp);
}).add;
)
// The Controls

x = Synth(\fxBank);
x.set(
    \which, 0, // Selects FX from fxNum array
    \amp, 1, // Master Amplitude control
    \freqFX, 100, // Used in any FX with a frequency parameter
    \gain, 1.0,
    \reset, 0,
    \reverbRoom, 0.5,
    \resonance, 0.5,
    \filterL, 600, // Low Pass filter cutoff
    \filterH, 6000, // High Pass filter cutoff
    \bits, 24, // BitCrush param
    \rate, 44100, // ^
    \mix, 0.33, // Resonance/Master mix
    \damp, 0.5, // Wet/Damp mix
    \delay, 2.0,
    \decay, 1.0,
    \diff, 0.707,
    \feedback, 0.0003,
    \depth, 0.1,
    \modFreq, 1.0, // Frequency modulation
    \rq, 1.0, // Reciprocal of Q
    \bwr, 1.0, // Bandwidth ratio (reciprocal of Q). rq = bandwidth/centerFreq.
    \delayNLC, 0, // Selects between non-interpolating, linear and cubic delays from delaySelection array
    \combNLC, 0, // Selects between non-interpolating, linear and cubic Comb filters from combSelection array
    \allpassNLC, 0, // Selects between non-interpolating, linear and cubic allpass filters from allpassSelection array
    \maxDelay, 1.0,
    \revTime, 3.0,
    \damping, 0.5,
    \inputBW, 0.5,
    \spread, 15,
    \dry, 0.5,
    \earlyReflection, 0.7,
    \tailLevel, 0.5,
    \maxRoom, 100 // Max room size
);
x.free;
