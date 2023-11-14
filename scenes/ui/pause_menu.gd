extends CanvasLayer

@onready var continue_button = %ContinueButton
@onready var options_button = %OptionsButton
@onready var main_menu_button = %MainMenuButton

var main_menu_scene: PackedScene = preload("res://scenes/ui/main_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	continue_button.pressed.connect(on_continue_pressed)
	main_menu_button.pressed.connect(on_main_menu_pressed)


func on_continue_pressed():
	get_tree().paused = false
	queue_free()


func on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_packed(main_menu_scene)
