extends CanvasLayer

signal transitioned_halfway
var skip_emit = false


func transition():
	$AnimationPlayer.play("default")
	await transitioned_halfway
	skip_emit = true
	$AnimationPlayer.play_backwards("default_reverse")
	
	
func transition_to_scene(scene_path: String):
	transition()
	await transitioned_halfway
	get_tree().change_scene_to_file(scene_path)

	
func emit_transition_halfway():
	# if skip_emit:
	#	skip_emit = false
	#	return
	transitioned_halfway.emit()
