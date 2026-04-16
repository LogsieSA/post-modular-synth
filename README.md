# The Post Modular Synth;
An array of computers ment to emulate the functions of a modular synth. Designed with live use in mind, this project rejects most single point of failures, if a node fails, the system continues as if nothing had happened, it fails gracefully, just leaving the overall song/performance with one less instrument until it gets fixed, rebooted and restarted.

This diagram depicts a basic 6 node set-up with a mixer, opting for maximum performance, minimal redundancy. Audio outputs are represented by green, audio inputs are represented by blue, networking cables by the yellow/gold, data by the black.


![A basic 6 node set-up.](https://github.com/LogsieSA/post-modular-synth/blob/main/Post-modular-diagram.png)

# "Quick" start guide;
To make one of your own post modular synths, you will need:
1. 2 or more spare computers, use cheap, old computers for the nodes which will be PTP slaves, a higher spec PC for the PTP grandmaster, the more cores and logical processors the better. Make sure that the PCs can boot well, replace the CMOS if their voltage is not up to scratch.
2. A good networking switch, PTP support is reccomended for a good sync, but optional.
3. Ethernet cables.
4. Small capacity SSDs.
5. A few keyboards.
6. A screen.
7. Cables to connect the node to the mixer. (If you are doing this with a mixer.)
8. Alot of male AUX to AUX cables.

OPTIONAL BUT ENCOURAGED;

9. A server rack to mount it all.
10. A network interface card that supports PTP to some extent.
11. An audio mixer, get something with alot of channels, if you want even less tactility just use NetJack and SuperCollider's ```SoundIn.ar```.
12. An audio interface, PCs send out a -10dBV signal, a mixer normally expects +4dBV. You *can* turn the gain up everywhere, but it leaves you with a faint hiss.
13. A spare GPU for the drum machine/master.
14. Good cooling, heat means jitter.
15. A MIDI keyboard.


INSTALLATION, BIOS CONFIGURATION AND OPERATING SYSTEM CONFIGURATION;
![Click here](https://github.com/LogsieSA/post-modular-synth/blob/main/SETUP.md).

# Final Note:
This is nowhere near as tactile or as hands on as an actual modular synth, if you want something more hands on, buy a few modules off eBay and enjoy. The upside of this set up over a traditional modular synth is the chaining and scalability, for instance, the dark pads/Bree Street Taxi Rank instrument would cost you alot of money to do on a Eurorack, but with this set up, you can run more than one on the same computer. In Eurorack, if you have an idea for a patch needing modules you do not own, you boot up ![VCVRack](https://vcvrack.com/), and make a patch using downloaded, similar modules to the ones you are planning on buying, once that is done, you spend money on the modules (If you can find them for sale) and shipping, you get it eventually and only then can you use it. With this digitized version, if you have an idea for a patch, you run ```$ scide``` and research what can make the sound/do the function you want, and you program, costing you only your time and patience.

