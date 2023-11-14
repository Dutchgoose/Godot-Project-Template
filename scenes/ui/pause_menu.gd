extends CanvasLayer

@onready var continue_button = %ContinueButton
@onready var options_button = %OptionsButton
@onready var main_menu_button = %MainMenuButton
@onready var pause_menu_body = %PauseMenuBody

var main_menu_scene: PackedScene = preload("res://scenes/ui/main_menu.tscn")
var options_menu_scene: PackedScene = preload("res://scenes/ui/options_menu.tscn")


func _ready():
	get_tree().paused = true
	continue_button.pressed.connect(on_continue_pressed)
	main_menu_button.pressed.connect(on_main_menu_pressed)
	options_button.pressed.connect(on_options_pressed)

func on_continue_pressed():
	get_tree().paused = false
	queue_free()


func on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_packed(main_menu_scene)


func on_options_pressed():
	var options_menu_instance = options_menu_scene.instantiate()
	options_menu_instance.back_pressed.connect(on_options_back_pressed.bind(options_menu_instance))
	pause_menu_body.visible = false
	add_child(options_menu_instance)

func on_options_back_pressed(options_menu: OptionsMenu):
	pause_menu_body.visible = true
	options_menu.queue_free()
