extends AudioStreamPlayer
class_name RandomAudioStreamPlayer

@export var streams: Array[AudioStream]
@export var min_pitch = 0.8
@export var max_pitch = 1.2


func play_random():
	if streams == null || streams.size() == 0:
		return
		
	pitch_scale = randf_range(min_pitch, max_pitch)
	
	stream = streams.pick_random()
	play()
