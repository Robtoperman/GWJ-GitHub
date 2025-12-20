extends AudioStreamPlayer

var loop_start := 1.8
var loop_end := 5.5

func setup(stream: AudioStream, start: float, end: float):
	self.stream = stream
	loop_start = start
	loop_end = end

func _process(delta):
	if playing and get_playback_position() >= loop_end:
		play(loop_start)
