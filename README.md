# midimatrix

![midimatrix](https://user-images.githubusercontent.com/10843208/177895595-ab3cdf49-fa71-45f3-93fc-83accc53fa9d.png)

This tool for Raspberry Pi monitors MIDI connections, and displays them in a OLED screen.

The grid shows MIDI outputs as rows, and MIDI inputs as columns, ordered in the same way, like a correlation matrix. A cross represents a connection. There are 4 ports max, as that's the max USB ports the RPi has.

## Install
Clone or download the repo as zip package, and run
```
sudo make install
```

## Setup OLED
In my case I'm using a SSD1306 128x64 display, and code is scaled for it.

Enable I2C,

```
sudo raspi-config
```
Go to `Interface Options` -> `I2C`, and turn on. Then connect your OLED screen using the I2C pins. You can read the pinout, and how to verify your device address [here](https://pinout.xyz/pinout/i2c).

If your I2C address is different from `0x3C`, run

```
sudo systemctl edit midimatrix
```
and it will open an editor, add this,

```
[Service]
ExecStart=/usr/bin/midimatrix --oled-i2c-address=03E
```
save, and restart the service

```
sudo systemctl daemon-reload
sudo systemctl restart midimatrix
```

## Add input buttons (optional)
You can wire a button to navigate, and make connections. Default pin is GPIO 26. Follow the steps above to customize the startup params. 

Press to move forward, and hold to connect/disconnect ports.

## Help
```
midimatrix --help
```

## Connect MIDI devices
You can just use the `aconnect` ALSA utility,

```bash
# List devices
aconnect -l

# Connect A to B
aconnect A B

# Disconnect B from A
aconnect -d A B

# Disconnect everything
aconnect -x
```

Or install [amidiauto](https://github.com/BlokasLabs/amidiauto) or [amidiminder](https://github.com/mzero/amidiminder), in which you can define rules to connect devices on startup and reconnect devices when available.
