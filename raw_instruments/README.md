# Navigation
In this directory you will find the raw instrument files and sample packs only, no pre-made/pre-packaged node images.

# The structure
I will keep the structure simple, each directory within this one will have labled folders with what you can expect to find in them.
1. The "Drums" directory will have my drum modules, these require a GUI to spawn a window to capture inputs.
2. The "Experimental" directory will have the weirder stuff, for example, a program which reads Base64 encoded strings and files as different notes.
3. The "Signals" directory will have your basic signals and ring modulation, using either SuperCollider's ```SoundIn.ar``` Ugen or its own internal oscillator.
4. The "FX" directory will have SuperCollider files that only have sound effects built in, they exclusively use the ```SoundIn.ar``` Ugen as the "in" signal.
5. The "Sequencer" directory will have basic sequencers with various step lengths, these work by sending a tiny sample of white noise over aux to the reciever, the receiver has a threshold to avoid random triggers, once above threshold, the noise is seen as a trigger.

More to come!
