extends CanvasLayer
@onready var hint_label = %HintLabel
@onready var hint_timer = %HintTimer
@onready var animation_player = $AnimationPlayer

var is_showing_hint = false

func _ready():
	hint_timer.timeout.connect(on_timer_timeout)


func show_hint_perpetual(text: String):
	if animation_player.is_playing():
		await animation_player.animation_finished
	if is_showing_hint:
		hide_hint()
	hint_label.text = text
	is_showing_hint = true
	animation_player.play("fade_in")
	

func show_hint(text: String):
	if animation_player.is_playing():
		await animation_player.animation_finished
	if is_showing_hint:
		hide_hint()
	hint_timer.start()
	hint_label.text = text
	is_showing_hint = true
	animation_player.play("fade_in")

func hide_hint():
	if is_showing_hint:
		if animation_player.is_playing():
			await animation_player.animation_finished
		is_showing_hint = false
		animation_player.play("fade_out")


func on_timer_timeout():
	if is_showing_hint:
		hide_hint()
