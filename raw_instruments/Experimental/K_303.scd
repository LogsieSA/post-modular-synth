// #IHateMyDAW :) 08/03/26
// K-303, Clanker controlled. 
// AY.ar with more frequency modulation, a RLPFD and Glitch filter.

s.boot;
(
SynthDef(\klanker303, {
	arg chipset = 0, toneA = 200, toneB = 250, toneC = 300,
	noise = 1, control = 7, volA = 15, volB = 15, volC = 15, envFreq = 4, envStyle = 1,
	snoise = 1, scontrol = 7, svolA = 15, svolB = 15, svolC = 15, senvFreq = 4, senvStyle = 1,
	curve = -4.0, cutoff = 700, res = 0.8, dist = 0.1, index = 1, sToneA = 400, sToneB = 500, sToneC = 600, rq =1, cfreq=500;
	var siggy, sound, carr, moduA, moduB, moduC;

	toneA = AY.freqtotone(toneA);
	toneB = AY.freqtotone(toneB);
	toneC = AY.freqtotone(toneC);

	moduA = (AY.ar(sToneA, 1, 1, snoise, scontrol, svolA,0,0, senvFreq, senvStyle, chipset) * (index * sToneA));
	moduB = (AY.ar(1, sToneB, 1, snoise, scontrol, 0,svolB,0, senvFreq, senvStyle, chipset) * (index * sToneB));
	moduC = (AY.ar(1, 1, sToneC, snoise, scontrol, 0,0,svolC, senvFreq, senvStyle, chipset) * (index * sToneC));
	sound =	(AY.ar(toneA + moduA, toneB + moduB, toneC + moduC, noise, control, volA, volB, volC, envFreq, envStyle, chipset));
	siggy = RLPFD.ar(sound, cutoff, res, dist);
	siggy = GlitchRHPF.ar(siggy, cfreq, rq);
	Out.ar(0, siggy ! 2);
}).add;
)

x=Synth(\klanker303);
x.set(\rq, 10);
x.set(\toneA, 131);
x.set(\toneB, 161);
x.set(\toneC, 414);
x.set(\sToneA, 1.54);
x.set(\sToneB, 15.49);
x.set(\sToneC, 12.111);
x.set(\chipset, 0);
x.set(\cfreq, 10);
x.set(\res, 0.5);
x.set(\dist,1);
x.set(\envStyle, 1);
x.set(\noise, 0.4);
x.set(\snoise, 0.34);
x.set(\cutoff, 5800);
x.set(\index, 100400);
x.set(\dist, 0);
