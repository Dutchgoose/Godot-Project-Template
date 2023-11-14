extends Button

@onready var random_audio_stream_player = %RandomAudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	mouse_entered.connect(on_mouse_entered)
	pressed.connect(on_pressed)


func play_sound():
	if (!disabled):
		random_audio_stream_player.play_random()


func on_pressed():
	play_sound()


func on_mouse_entered():
	play_sound()
