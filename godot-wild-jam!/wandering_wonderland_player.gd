extends AudioStreamPlayer

var loop_start := 54.0
var loop_end := 0.0
var duration := 0.0

func setup(stream: AudioStream, start: float, end: float):
	self.stream = stream
	loop_start = start
	loop_end = end
	duration = stream.get_length()
