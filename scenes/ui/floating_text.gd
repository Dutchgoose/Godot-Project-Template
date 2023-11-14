extends Node2D


func _ready():
	pass
	
	
func start(text: String):
	# Add some random positioning so numbers don't stack if hit two times at once
	var random_offset = randi_range(-2, 2)
	var offset_vector = Vector2.LEFT * random_offset
	var spawn_position = global_position + offset_vector
	$Label.text = text
	var tween = create_tween()
	tween.set_parallel()
	
	tween.tween_property(self, "global_position", spawn_position + (Vector2.UP * 16), 0.3)\
	.set_ease(Tween.EASE_OUT)\
	.set_trans(Tween.TRANS_CUBIC)

	# Pause for popup
	tween.chain()
	
	tween.tween_property(self, "global_position", spawn_position + (Vector2.UP * 48), 0.5)\
	.set_ease(Tween.EASE_IN)\
	.set_trans(Tween.TRANS_CUBIC)
	
	tween.tween_property(self, "scale", Vector2.ONE, 0.5)\
	.set_ease(Tween.EASE_IN)\
	.set_trans(Tween.TRANS_CUBIC)
	
	tween.chain()
	tween.tween_callback(queue_free)

	var scale_tween = create_tween()
	scale_tween.tween_property(self, "scale", Vector2.ONE * 1.5, 0.15)\
	.set_ease(Tween.EASE_OUT)\
	.set_trans(Tween.TRANS_CUBIC)
	
	scale_tween.tween_property(self, "scale", Vector2.ONE * 1, 0.15)\
	.set_ease(Tween.EASE_IN)\
	.set_trans(Tween.TRANS_CUBIC)
	
