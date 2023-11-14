extends CharacterBody2D

@export var arena_time_manager: Node
@export var the_flame: Node2D
@onready var damage_interval_timer = $DamageIntervalTimer
@onready var health_component = $HealthComponent
@onready var health_bar = $HealthBar
@onready var abilities = $Abilities
@onready var animation_player = $AnimationPlayer
@onready var visuals = $Visuals
@onready var velocity_component = $VelocityComponent
@onready var level_up_component = $LevelUpComponent
@onready var healing_component = $HealingComponent

var number_colliding_bodies = 0
var base_speed = 0

var is_healing = false


func _ready():
	arena_time_manager.arena_difficulty_increased.connect(on_arena_difficulty_increased)
	the_flame = get_tree().get_first_node_in_group("the_flame")
	if the_flame != null:
		the_flame.the_flame_area_entered.connect(on_flame_entered)
		the_flame.the_flame_area_exited.connect(on_flame_exited)
	base_speed = velocity_component.max_speed
	$CollisionArea2D.body_entered.connect(on_body_entered)
	$CollisionArea2D.body_exited.connect(on_body_exited)
	damage_interval_timer.timeout.connect(on_damage_interval_timer_timeout)
	health_component.health_decreased.connect(on_health_decreased)
	health_component.health_changed.connect(on_health_changed)
	healing_component.healing_time.connect(on_healing_time_triggered)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)
	update_health_display()


func _process(delta):
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	velocity_component.accelerate_in_direction(direction)
	velocity_component.move(self)
	
	if (movement_vector.x != 0 || movement_vector.y != 0):
		animation_player.play("walk")
	else:
		animation_player.play("RESET")
		
	var move_sign = sign(movement_vector.x)
	if move_sign != 0:
		visuals.scale = Vector2(move_sign, 1)


func get_movement_vector():
	var velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return velocity

func check_deal_damage():
	if number_colliding_bodies == 0 || !damage_interval_timer.is_stopped():
		return
	health_component.damage(1)
	damage_interval_timer.start()


func update_health_display():
	health_bar.value = health_component.get_health_percent()


func level_up():
	level_up_component.play()


func on_body_entered(other_body: Node2D):
	number_colliding_bodies += 1
	check_deal_damage()
	

func on_body_exited(other_body: Node2D):
	number_colliding_bodies -= 1
	
	
func on_damage_interval_timer_timeout():
	check_deal_damage()


func on_health_decreased():
	GameEvents.emit_player_damaged()
	$HitRandomStreamPlayer.play_random()
	

func on_health_changed():
	update_health_display()

	
func on_ability_upgrade_added(ability_upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if ability_upgrade is Ability:
		var ability = ability_upgrade as Ability
		abilities.add_child(ability.ability_controller_scene.instantiate())
	elif ability_upgrade.id == "player_speed":
		velocity_component.max_speed = base_speed + (base_speed * current_upgrades["player_speed"]["quantity"] * 0.1)


func on_arena_difficulty_increased(difficulty: int):
	var health_regeneration_quantity = MetaProgression.get_upgrade_count("health_regeneration")
	if health_regeneration_quantity > 0:
		var is_thirty_second_interval = (difficulty%6) == 0
		if is_thirty_second_interval:
			health_component.heal(health_regeneration_quantity)
	

func on_flame_entered():
	is_healing = true
	healing_component.start_emitting()
	print_debug('entered')
	pass


func on_flame_exited():
	is_healing = false
	healing_component.stop_emitting()
	print_debug('exited')
	pass


func on_healing_time_triggered():
	var max_health = health_component.max_health
	var amount_to_heal = int(max_health/10)
	health_component.heal(amount_to_heal)
