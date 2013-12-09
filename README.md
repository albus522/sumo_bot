# Sumo Bot

This is how I controlled my sumo bot using a [leap motion](https://www.leapmotion.com/).

## Hardware

- [Leap Motion](https://www.leapmotion.com/)
- [Arduino Uno](http://arduino.cc/en/Main/ArduinoBoardUno)
- 2 continuous motion servos
- Robot frame pieces [sumobot-jr](https://github.com/makenai/sumobot-jr)

## Software

You need to have:
- Only tried on OS X Mavericks
- StandardFirmata flashed on your Arduino Uno
- Leap Motion installed on your computer

## Wiring

I connected the left servo to pin 3 and the right servo to pin 9. Any PWM pins will do but you will need to adjust servo.rb accordingly

Connect the Leap Motion and Arduino to your computer via USB.

## Setup

Install gem dependencies

    $ bundle install

Before you plug in your Arduino run

    $ artoo connect scan

Then after you plug in your Arduino run the same command again and look for a new entry.
This will be the device file to reference at the top of servo.rb

## Running

    $ ruby leap.rb | ruby servo.rb
