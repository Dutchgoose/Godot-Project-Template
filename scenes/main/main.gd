extends Node

@export var end_screen_scene: PackedScene

var paused_menu_scene = preload("res://scenes/ui/pause_menu.tscn")
@onready var hint_ui = %HintUI


func _ready():
	hint_ui.show_hint("Protect the flame")


func _unhandled_input(event):
	if (event.is_action_pressed("pause")):
		add_child(paused_menu_scene.instantiate())
		get_tree().root.set_input_as_handled() # stop the input from propagating up the tree
