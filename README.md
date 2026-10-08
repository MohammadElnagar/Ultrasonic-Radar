# Arduino Ultrasonic Radar

A real-time radar built with an Arduino UNO, an HC-SR04 ultrasonic sensor and a servo motor. The servo sweeps the sensor back and forth, and a Processing sketch on the computer draws the results on a radar-style screen.

## Demo

<img width="576" height="1024" alt="radar 1 1" src="https://github.com/user-attachments/assets/7fe07130-ffca-4d1f-9e9c-e106ca612998" />

https://github.com/user-attachments/assets/d6a568b6-0ac0-420e-a95d-4165062e8624

https://github.com/user-attachments/assets/87460fbc-0f01-4fbb-a1cd-5654a8a65214




## Parts

- Arduino UNO
- HC-SR04 ultrasonic sensor
- SG90 servo motor
- Breadboard
- Jumper wires
- USB cable

## Wiring

| Component | Connects to |
|-----------|-------------|
| HC-SR04 VCC | Breadboard + (5V) rail |
| HC-SR04 GND | GND |
| HC-SR04 TRIG | Arduino pin 9 |
| HC-SR04 ECHO | Arduino pin 10 |
| Servo red wire | Breadboard + (5V) rail |
| Servo black/brown wire | Breadboard - (GND) rail |
| Servo signal wire (orange/yellow) | Arduino pin 11 |
| Arduino 5V | Breadboard + rail |
| Arduino GND | Breadboard - rail |

## How it works

1. The servo rotates the sensor through an arc.
2. At each angle, the HC-SR04 sends an ultrasonic pulse and measures how long the echo takes to return.
3. The Arduino converts that time into a distance and sends the angle and distance to the computer over USB serial.
4. The Processing sketch reads that data and draws the radar sweep and any detected objects in real time.

## Software

- [Arduino IDE](https://www.arduino.cc/en/software) to upload the sketch to the board
- [Processing 4.5.7](https://processing.org/download) to run the radar display

## How to run

1. Wire the circuit as shown above.
2. Open `radar.ino` in the Arduino IDE and upload it to the UNO.
3. Close the Arduino Serial Monitor, since it blocks the port.
4. Open `radar.pde` in Processing.
5. If nothing shows up, change `PORT_INDEX` in the code to match your Arduino's port.
6. Press Run to see the radar. Press Esc to quit.

## Files

- `radar.ino`: Arduino code
- `radar.pde`: Processing display code

