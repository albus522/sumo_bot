require 'artoo'

connection :leapmotion, :adaptor => :leapmotion, :port => '127.0.0.1:6437'
device :leapmotion, :driver => :leapmotion

LEFT_RIGTH = 0
FORWARD_REVERSE = 1
INT_FRAME_COUNT = 40
AVG_FRAME_COUNT = 5

LR_SLOW = 0.08
FB_SLOW = 0.15

work do
  on leapmotion, :frame => :on_frame
end

def on_frame(*args)
  frame = args[1]
  @frames ||= []
  if frame.hands.any?
    @frames << frame.hands.first.direction
    if @ready
      @frames.shift if @frames.size > AVG_FRAME_COUNT
      xyz = @frames.inject([0,0,0]) {|s,i| [s[0] + i[0], s[1] + i[1], s[2] + i[2]] }.map {|i| i / @frames.size }
      lr = @center[LEFT_RIGTH] - xyz[LEFT_RIGTH]
      fr = @center[FORWARD_REVERSE] - xyz[FORWARD_REVERSE]
      dir = ""

      if lr > LR_SLOW
        dir << "l"
      elsif lr < -LR_SLOW
        dir << "r"
      end

      if fr < -FB_SLOW
        dir << "b"
      elsif fr > FB_SLOW
        dir << "f"
      end

      dir = "S" if dir.empty?

      $stdout.puts dir
    elsif @frames.size >= INT_FRAME_COUNT
      @ready = true
      10.times { @frames.shift }
      @center = @frames.inject([0,0,0]) {|s,i| [s[0] + i[0], s[1] + i[1], s[2] + i[2]] }.map {|i| i / @frames.size }
    end
  else
    $stdout.puts "S" if @frames.size > 0
    @ready = false
    @frames = []
  end
  $stdout.flush
end
