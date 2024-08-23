extends CharacterBody2D

@export var base_speed = 300
var speed
@export var fuel = 500
@export var prev_fuel = fuel
@export var max_fuel = 500
@export var health = 40
var prev_health = health
@export var max_health = 40
@export var min_health = 0
@export var interpolation_factor : float = 0.1
@export var rotation_offset : int = 0
@export var joystick_left : VirtualJoystick
@export var joystick_right : VirtualJoystick
@export var flash_duration : float

@onready var sprite = $AnimatedSprite2D
@onready var flash_timer = $FlashTimer
@onready var weapon = $New_Lawnmower
@onready var spawner = $"../Spawner"
@onready var mob_hurt_shader = preload("res://Mobs/mob_hurt_material.tres")

var enemies_touching : Array = []
var move_vector := Vector2.ZERO
signal display_health
signal display_fuel


func _ready():
	speed = base_speed
	GameManager.connect("mob_death",on_mob_death)
	
func _physics_process(delta) -> void:
	#print_debug("speed: ",speed)
	process_joystick(delta)
	move_and_slide()

func _process(_delta):
	check_health(health)
	check_fuel(fuel)
	
func process_joystick(delta):
	velocity = Vector2(0,0)
	#Movement
	if joystick_left and joystick_left.is_pressed:
		if(fuel > 0):
			fuel -= 0.5
		position += joystick_left.output * speed * delta
	#Rotation
	if joystick_right and joystick_right.is_pressed:
		var new_rotation = (rad_to_deg(joystick_right.output.angle()) + rotation_offset)
		if rotation_degrees < -90 and new_rotation > 0:
			rotation_degrees = new_rotation
		if rotation_degrees > 10 and new_rotation < 0:
			rotation_degrees = new_rotation
		rotation_degrees = lerp(rotation_degrees, new_rotation, interpolation_factor)


func _on_hit_box_body_entered(body):
	if body.is_in_group("Mob"):
		var enemy_already_touching = enemies_touching.filter(func(enemy): return enemy['this_mob'] == body.this_mob)
		if enemy_already_touching:
			var enemy_index = enemies_touching.find(enemy_already_touching[0])
			enemies_touching[enemy_index].amount += 1
		else: 
			enemies_touching.append({"this_mob":body.this_mob,"damage":body.damage,"amount":1})

func _on_hit_box_body_exited(body):
	if body.is_in_group("Mob"):
		var enemy_already_touching = enemies_touching.filter(func(enemy): return enemy['this_mob'] == body.this_mob)
		if enemy_already_touching:
			var enemy_index = enemies_touching.find(enemy_already_touching[0])
			enemies_touching[enemy_index].amount -= 1
		var enemies_at_zero = enemies_touching.filter(func(enemy): return enemy['amount'] == 0)
		if(enemies_at_zero):
			for enemy in enemies_at_zero:
				enemies_touching.erase(enemy)
	
	
func process_damage(enemies):
	#process player damage per amount of enemies touching
	var total_damage = 0
	if enemies:
		sprite.material = mob_hurt_shader
		flash_timer.start(flash_duration)
		for enemy in enemies:
			total_damage += enemy.damage * enemy.amount
	health -= total_damage
	if health <= 0:
		GameManager.on_game_over()

func _on_damage_frequency_timeout():
	process_damage(enemies_touching)
	
func _on_flash_timer_timeout():
	sprite.material = null
func _on_speed_boost_timer_timeout():
	speed = base_speed
func on_mob_death(mob_type,mob_position):
	speed += 300
	$SpeedBoostTimer.start(0.1)
	
func check_health(current_health):
	if(current_health != prev_health):
		display_health.emit()
	prev_health = current_health

func check_fuel(current_fuel):
	if(fuel <= 0):
		speed = base_speed * 0.25
	else:
		speed = base_speed
	if(current_fuel != prev_fuel):
		display_fuel.emit()
	prev_fuel = current_fuel


