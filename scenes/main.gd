extends Node

var pause_menu: PackedScene = preload("res://scenes/ui/pause_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = get_tree().create_timer(5)
	await timer.timeout
	
func _process(_delta: float):
	if (Input.is_action_just_pressed("escape")):
		add_child(pause_menu.instantiate())
