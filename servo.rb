require 'artoo'

# Alter this to use the device your arduino connects as
connection :arduino, :adaptor => :firmata, :port => '/dev/tty.usbmodem1421'

device :board, :driver => :device_info
# Update these pin settings or rewire your servos as necessary
device :servo1, :driver => :servo, :pin => 3 # pin must be a PWM pin Left Servo
device :servo2, :driver => :servo, :pin => 9 # pin must be a PWM pin Right Servo

# Tweak these until both wheels hold still
# or use the servo adjustment screws
S1_OFF = 66
S2_OFF = 67

HIGH_SPEED = 25
LOW_SPEED = 5

work do
  puts "Firmware name: #{board.firmware_name}"
  puts "Firmata version: #{board.version}"

  while s = $stdin.gets.strip
    puts s
    case s
    when "l"
      servo1.move(S1_OFF)
      servo2.move(S2_OFF - HIGH_SPEED)
    when "lf"
      servo1.move(S1_OFF + LOW_SPEED)
      servo2.move(S2_OFF - HIGH_SPEED)
    when "lb"
      servo1.move(S1_OFF - HIGH_SPEED)
      servo2.move(S2_OFF + LOW_SPEED)
    when "r"
      servo1.move(S1_OFF + HIGH_SPEED)
      servo2.move(S2_OFF)
    when "rf"
      servo1.move(S1_OFF + HIGH_SPEED)
      servo2.move(S2_OFF - LOW_SPEED)
    when "rb"
      servo1.move(S1_OFF - LOW_SPEED)
      servo2.move(S2_OFF + HIGH_SPEED)
    when "b"
      servo1.move(S1_OFF - HIGH_SPEED)
      servo2.move(S2_OFF + HIGH_SPEED)
    when "f"
      servo1.move(S1_OFF + HIGH_SPEED)
      servo2.move(S2_OFF - HIGH_SPEED)
    when "S"
      servo1.move(S1_OFF)
      servo2.move(S2_OFF)
    end
  end
end
