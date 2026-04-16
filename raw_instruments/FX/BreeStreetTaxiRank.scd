s.boot;
s.quit;

// #IHateMyDAW :) 06/03/26
//
// Dark, damp and massively reverberant fx processor with spectral smearing.
// Inspired by the Bree Street Taxi Rank in Johannesburg, a massive, dark, dirty, damp and reverberant, multi-floored parking lot
// made from brick and piss stained-concrete, where sound curves and bounces against the damp, stained concrete pillars.
//
// "The place is filthy and dark. Seems like all hope is lost when it comes to the upkeep of this place...."
// -Prince Mbatha, Google reviews.

(
// Change these directories...


SynthDef(\breeStreetTaxiRank, {
	arg
	fx = 0, rt60 = 1, amp = 1.0, earlyRef = 0.7,
	stereo = 0.5, lowFreq = 200, lowRatio = 0.5, hiFreq = 4000, hiRatio = 0.5,
	earlyDiffusion = 0.5, lateDiffusion = 0.5, modRate = 0.2, modDepth = 0.3, trigger = 1.0, startPos = 0.0,
	cutoff=7000, brickNumber=0.1;
	var pillars, fxArr, fxFinal, siggyFinal, siggy, letThatBitchBreathe;


	siggy = SoundIn.ar(0) ! 2;
	letThatBitchBreathe = NHHall.ar(siggy, rt60, stereo, lowFreq, lowRatio, hiFreq, hiRatio, earlyDiffusion, lateDiffusion, LFNoise0.kr(1).exprange(10,100), LFNoise0.kr(1).exprange(1,10));
	pillars = FFT(LocalBuf(2048), siggy);
	pillars = PV_MagSmear(pillars, brickNumber);
	pillars = IFFT(pillars);
	fxArr = [
		NHHall.ar(siggy, rt60, stereo, lowFreq, lowRatio, hiFreq, hiRatio, earlyDiffusion, lateDiffusion, modRate, modDepth),
		letThatBitchBreathe,
		NHHall.ar(pillars, rt60, stereo, lowFreq, lowRatio, hiFreq, hiRatio, earlyDiffusion, lateDiffusion, modRate, modDepth),
	];

	fxFinal = SelectX.ar(fx, fxArr);
	siggyFinal = LPF.ar(fxFinal, cutoff);
	Out.ar(0, siggyFinal * amp);
}).add
)
x=Synth(\breeStreetTaxiRank);
x.set(\cutoff, 8900); // Final LPF cutoff frequency
x.set(\hiFreq, 5500); // The high frequency cutoff within the NHHall.
x.set(\lowFreq, 190); // The low frequency cutoff within the NHHall
x.set(\earlyDiffusion, 0.8);
x.set(\lowRatio,0.9); // Low frequency decay rate modifier
x.set(\hiRatio,0.9); // High frequency decay rate modifier
x.set(\rt60, 20); // Decay time of mid frequencies
x.set(\lateDiffusion,0.9);
x.set(\modRate,1.0);
x.set(\loop, 1);
x.set(\doneAction,0);
x.set(\fx, 3);
x.set(\brickNumber, 10); // Sets the 'bins' argument in the PV_MagSmear function
x.set(\modDepth,1);
x.set(\amp,1);


y=Synth(\breeStreetTaxiRank);
y.set(\cutoff, 3500); // Final LPF cutoff frequency
y.set(\hiFreq, 2000); // The high frequency cutoff within the NHHall.
y.set(\lowFreq, 200); // The low frequency cutoff within the NHHall
y.set(\earlyDiffusion, 0.4);
y.set(\lowRatio,0.4); // Low frequency decay rate modifier
y.set(\hiRatio,0.6); // High frequency decay rate modifier
y.set(\rt60, 5); // Decay time of mid frequencies
y.set(\lateDiffusion,0.9);
y.set(\modRate,1.0);
y.set(\loop, 1);
y.set(\doneAction,0);
y.set(\fx, 3);
y.set(\brickNumber, 1); // Sets the 'bins' argument in the PV_MagSmear function
y.set(\modDepth,1);
y.set(\amp,1);
y.free;
