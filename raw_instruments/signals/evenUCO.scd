s.boot;
// #IHateMyDAW :)
// UCO with 4 different mixable signals (Sine, Saw, Triangle, Square), ring modulation and a small, built in FX bank.
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
	noise=0.0003
	;
	var modu, carr, fOut, fxBank, fxOut;
	modu = (SinOsc.ar(sFreq) * dex);
	carr = (SinOsc.ar(mFreq + modu) * siAmp) + (Saw.ar(mFreq + modu) * saAmp) + (LFTri.ar(mFreq + modu) * trAmp) + (PulseDPW.ar(mFreq + modu) * sqAmp);
	fxBank = [
		carr = carr, //index 0 (passthrough)
		FreeVerb.ar(carr, mix, room, damp), //index 1
		MoogFF.ar(carr, fxFreq, gain), //index 2
		CombC.ar(carr, maxDelay, delayTime, decayTime), //index 3
		Greyhole.ar(carr, delayTime, damp, room, diff, feedback, depth, modFreqFX), //index 4
		Decimator.ar(carr, rate, bits), //index 5
		DFM1.ar(carr, fxFreq, res, gain, type, noise) //index 6
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
	\sqAmp,0.4);
x.free;
y = Synth(\uco);
y.set(\siAmp, 0.5,
	\trAmp,0.5,
	\sqAmp, 0.9,
	\saAmp, 0.9,
	\dex, 10,
	\fX, 0,
	\room, 0.9,
	\res, 0.5,
	\bits, 24,
	\mFreq, 150,
	\sFreq, 60*2);
y.free;

z = Synth(\uco);
z.set(\siAmp, 1,
	\trAmp,1,
	\sqAmp, 0.9,
	\saAmp, 0.9,
	\dex, 5,
	\resFreq, 200,
	\mFreq, 150,
	\sFreq, 5);
z.free;
