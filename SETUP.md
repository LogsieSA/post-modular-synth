# Stepset 0;
1. Download the latest ![Debian](https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-13.4.0-amd64-netinst.iso) version.
2. Write that image to a USB.
3. Insert your boot USB into a prepared motherboard, plug your switch into said motherboard.
4. Go into your BIOS and do the following
5. Turn off virtualization.
6. Turn off C-States.
7. Turn off Eco modes, these cause changes in clock speed
8. Turn off Intel Turbo Boost/AMD Precision Boost, Multi-core Enhancement.
9. Turn off Intel SpeedStep/AMD Cool'n'Quiet, CPPC etc.
10. Manually set the CPU multiplier with a fixed ratio.
11. Disable all Spread Spectrum settings.
12. Lock the BCLK frequency.
13. Boot into your Debian USB.
14. Select graphical install and follow the instructions. If your computer cannot load the graphical install, use a normal install and DO NOT install a display manager.
15. Set your username and password to something short and easy to type in a pinch.
16. Select LXQt as your display manager.
17. Remove the USB and boot into your Debian installation.

# Stepset 1;
1. Log in.
2. Open your settings and disable any and all sleep/power management settings.
3. Stay in the settings and enable RDP.
4. Run the command:
   ```sudo apt install scide sc3-plugins linux-image-rt-amd64 linux-headers-rt-amd64 jackd2 alsa-utils git rtirq-init```
5. Set your IP address to static, ```sudo nano /etc/networks/interfaces```.
6. Install ![mi-Ugens](https://github.com/v7b1/mi-UGens).
7. Reboot.
