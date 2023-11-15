extends Node

@onready var continue_button = %ContinueButton
@onready var loading_label = %LoadingLabel
@onready var loading_sprite = %LoadingSprite

var main_scene_path = "res://scenes/main.tscn"
var loading_progress = []
var scene_load_status = 0
var main_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	continue_button.pressed.connect(func(): get_tree().change_scene_to_packed(main_scene))
	ResourceLoader.load_threaded_request(main_scene_path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float):
	scene_load_status = ResourceLoader.load_threaded_get_status(main_scene_path, loading_progress)
	if (scene_load_status == ResourceLoader.THREAD_LOAD_LOADED):
		main_scene = ResourceLoader.load_threaded_get(main_scene_path)
		# In this template if you do not have an "await" here loading
		# happens too fast and you can't see the loading logic at work visually.
		await get_tree().create_timer(1).timeout
		loading_label.visible = false
		continue_button.visible = true
		loading_sprite.visible = false
