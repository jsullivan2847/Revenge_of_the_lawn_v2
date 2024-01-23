extends Node2D

@export var speed = 200
@export var health = 20
@export var interpolation_factor : float = 0.1
@export var rotation_offset : int = 0
@export var joystick_left : VirtualJoystick
@export var joystick_right : VirtualJoystick
@export var flash_duration : float

@onready var sprite = $AnimatedSprite2D
@onready var flash_timer = $FlashTimer
@onready var mob_hurt_shader = preload("res://Mobs/mob_hurt_material.tres")

var enemies_touching : Array = []
var move_vector := Vector2.ZERO
signal display_health


func _ready():
	pass
	
func _process(delta: float) -> void:
	process_joystick(delta)
	
func process_joystick(delta):
	if joystick_left and joystick_left.is_pressed:
		position += joystick_left.output * speed * delta
		
	if joystick_right and joystick_right.is_pressed:
		var new_rotation = (rad_to_deg(joystick_right.output.angle()) + rotation_offset)
		if rotation_degrees < -90 and new_rotation > 0:
			rotation_degrees = new_rotation
		if rotation_degrees > 10 and new_rotation < 0:
			rotation_degrees = new_rotation
		rotation_degrees = lerp(rotation_degrees, new_rotation, interpolation_factor)


func _on_hit_box_body_entered(body):
	#tracks how many enemies currently touching
	var enemy_already_touching = enemies_touching.filter(func(enemy): return enemy['type'] == body.type)
	if enemy_already_touching:
		var enemy_index = enemies_touching.find(enemy_already_touching[0])
		enemies_touching[enemy_index].amount += 1
	else: 
		enemies_touching.append({"type":body.type,"damage":body.damage,"amount":1})

func _on_hit_box_body_exited(body):
	#tracks how many enemies currently touching
	var enemy_already_touching = enemies_touching.filter(func(enemy): return enemy['type'] == body.type)
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
	display_health.emit()

func _on_damage_frequency_timeout():
	process_damage(enemies_touching)
	


func _on_flash_timer_timeout():
	sprite.material = null
