# This code was inspired by StdOutCapturer at 
# http://jerith.za.net/code/capturestdout.html

class StdOutString < String
  def write(s)
    self << s
  end
end

def capture_stdout(&block)
  real_stdout = $stdout
  captured_stdout = StdOutString.new
  $stdout = captured_stdout
  result = yield
  $stdout = real_stdout
  return captured_stdout, result
end

