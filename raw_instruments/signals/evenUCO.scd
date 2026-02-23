s.boot;
// #IHateMyDAW :)
(SynthDef(\uco, {
	arg mFreq=110,
	sFreq=220,
	amp=1,
	dex=1,
	fxFreq=100,
	gain=1.0,
	siAmp=0,
	saAmp=0,
	trAmp=0,
	sqAmp=0,
	fX=0,
	mix=0.33,
	room=0.5,
	damp=0.5,
	maxDelay=0.2,
	delayTime=0.2,
	decayTime=0.5,
	feedback=0.9,
	depth=0.1,
	modFreqFX=2.0,
	diff=0.707,
	rate=44100,
	bits=24,
	res=0.1,
	type=0.0,
	noise=0.0003,
	moduSelection=0;
	var carr, fOut, fxBank, fxOut, moduInArray, modu;

	moduInArray = [
		SinOsc.ar(sFreq) * dex, //0: Modulation internally
		SoundIn.ar(0) * dex //1: Modulation via SoundIn.ar
	              ];
	modu = Select.ar(moduSelection, moduInArray);
	carr = (SinOsc.ar(mFreq + modu) * siAmp) + (Saw.ar(mFreq + modu) * saAmp) + (LFTri.ar(mFreq + modu) * trAmp) + (PulseDPW.ar(mFreq + modu) * sqAmp);
	fxBank = [
		carr = carr, //0: None (Pass-through)
		FreeVerb.ar(carr, mix, room, damp), //1: reverb
		MoogFF.ar(carr, fxFreq, gain), //2: Moog Ladder filter
		CombC.ar(carr, maxDelay, delayTime, decayTime), //3: Cubic Comb filter
		Greyhole.ar(carr, delayTime, damp, room, diff, feedback, depth, modFreqFX), //4: Huge reverb
		Decimator.ar(carr, rate, bits), //5: Bit Crush
		DFM1.ar(carr, fxFreq, res, gain, type, noise) //6: Analog filter
	];

	fxOut = Select.ar(fX, fxBank);
	fOut = fxOut;
	fOut = Limiter.ar(fOut, 0.8);
	Out.ar(0, fOut ! 2 * amp);
}).add;
)

x = Synth(\uco);
x.set(\sFreq, 90,
	\dex, 100,
	\mFreq, 150,
	\gain, 1.0,
	\diff, 0.5,
	\delayTime, 0.5,
	\modFreqFX, 100,
	\fX, 6,
	\feedback,0.0001,
	\damp, 0.9,
	\room, 2,
	\depth, 1,
	\siAmp,1,
	\saAmp,0.4,
	\trAmp,1,
	\sqAmp,0.4,
	\moduSelection,0);
x.free;
