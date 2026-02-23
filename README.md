# The Post Modular Synth
A fault-tolerant, digital, Beowulf cluster designed to emulate the functions of a modular synth. Designed with live use in mind, this project rejects most single point of failures, if a node fails, the system continues as if nothing had happened, it fails gracefully, just leaving the overall song/performance with one less instrument until it gets fixed, rebooted and restarted.

This diagram depicts a basic 6 node set-up with maximum performance, minimal redundancy. Audio outputs are represented by green, audio inputs are represented by blue, networking cables by the yellow/gold, data by the black.


![A basic 6 node set-up.](https://github.com/LogsieSA/post-modular-synth/blob/main/Post-modular-diagram.png)

# "Quick" start guide.
To make one of your own post modular synths, you will need:
1. 2 or more spare computers, use cheap, old computers for the nodes which will be PTP slaves, a higher spec PC for the PTP grandmaster, the more cores and logical processors the better. Make sure that the PCs can boot well, replace the CMOS if their voltage is not up to scratch.
2. A good networking switch, PTP support is reccomended for a good sync.
3. Ethernet cables.
4. Small capacity SSDs.
5. An audio mixer, get something with alot of channels.
6. A few keyboards.
7. A screen.
8. Cables to connect the node to the mixer.

OPTIONAL BUT ENCOURAGED:

9. A server rack to mount it all.
10. A network interface card that supports PTP to some extent.
11. An audio interface, PCs send out a -10dBV signal, a mixer normally expects +4dBV. You *can* turn the gain up everywhere, but it leaves you with a faint white noise.
12. A spare GPU for the drum machine/master.
13. Good cooling, heat introduces jitter.
14. If you are a bit overkill, a PS/2 keyboard for the drums.
15. A MIDI keyboard for more complex synthesizers.

After you have all of that, configure the BIOS as follows:
1. Turn off virtualization.
2. Turn off C-States.
3. Turn off Eco modes, these cause changes in clock speed
4. Turn off Intel Turbo Boost/AMD Precision Boost, Multi-core Enhancement.
5. Turn off Intel SpeedStep/AMD Cool'n'Quiet, CPPC etc.
6. Manually set the CPU multiplier with a fixed ratio.
7. Disable all SPread Spectrum settings.
8. Lock BCLK and set it manually.
9. For the grandmaster PTP clock, disable iGPU.

Then you can proceed to install the actual OS, we are running headless Debian with a realtime kernel, PTP is already installed but needs to be configured. The username for the nodes are the hostname of the node, if numbers are present then it is spelt out (e.g nineohnine), the passwords are always "31_10_25". To install the images, download the desired intrument's torrent file in the [images directory](https://github.com/LogsieSA/post-modular-synth/tree/main/Images). Then use [balenaEtcher](https://etcher.balena.io/#download-etcher) or any desired imager to write the image to the SSD once you have a way to connect it to your main PC. Once done, stall it into the PC, boot, log in.

After the OS is installed, because the NICs are different in interface name, you may have to: ```$ nano /etc/network/interfaces``` and configure from there. Then set up the PTP, use ```$ man ptp41``` and decide which node will be the master, I heavily reccomend making this a service which auto-starts once you have the configuration dialed in for every node to save you some headaches. Use the grandmaster images to act as the grandmaster clock, install on the best PC of the bunch. They come with a GUI and a few drum machines and zipped samples, A drum machine is hell to program headless, trust me, I tried. After the base OS is installed, isolate the cpus and dedicate them to tasks, say we have 6 cores for our GM, cores 0-1 are for the OS and any IRQ interupts, cores 2-4 handle PTP, NIC IRQs and phc2sys, with core 5 running SuperCollider.

# Final note.
This instrument was built because I think that charging 200$ for a simple Voltage Controlled Oscillator was extortionate, this machine will not have the exactness of a real modular synth, but it can, in theory, get very close with proper tuning. Even with proper tuning the price for a new module wont be as bad as buying a new module for a modular synth, and instead of having to pay hundreds or thousands for a more complicated module, the price of a node is relatively fixed, categorized into non timing sensitive and timing sensitive, the timing sensitive nodes need more cores, so it will cost more, nodes in this group would be, in order of timing priority: Drum machines/Grandmasters, Bassline synths, timing dependent VCOs and regular synths. Non-timing critical nodes include: VCOs with simple modulation, LFOs, filters and FX modules. Whereas, if you wanted a drum machine for a modular, you are looking at upwards of $900. For that $900 price tag, you could use fiber to synchronize all of the nodes, with latency in theory being <1 microsecond. This idea came from seeing Colin Benders live and wanting a modular synth, then seeing module prices, trying to design my own circuits, giving up and asking myself "How would I do it with what I have?". In a live environment I recommend having many many redundant components, this way if a critical node fails, you have jitter or lack of drums for a while while you replace the failed nodes. With no redundancy you might find youself in a position where you are actively configuring a ```/etc/network/interfaces/ configuration file in front of a live crowd, which will not be fun. Still, with all these seemingly steep requirements, it will be cheaper than the analog synth alternative.
