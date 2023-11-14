extends CanvasLayer

@onready var play_button = %PlayButton
@onready var options_button = %OptionsButton
@onready var quit_button = %QuitButton

var loading_scene: PackedScene = preload("res://scenes/ui/loading_screen.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	play_button.pressed.connect(func(): get_tree().change_scene_to_packed(loading_scene))
	quit_button.pressed.connect(func(): get_tree().quit())
