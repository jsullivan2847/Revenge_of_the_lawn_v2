class_name Mob extends CharacterBody2D

enum MOB_TYPE {BASE_MOB,VENUS}
var mob_dead = false
@export var this_mob = MOB_TYPE.BASE_MOB
@export var health : int = 0
@export var damage : int = 0
@export var speed : int = 0
@export var flash_duration : float
@onready var flash_timer = $FlashTimer
@onready var sprite: Sprite2D = $Sprite2D
@onready var mob_hurt_shader = preload("res://Mobs/mob_hurt_material.tres")

@onready var overlay = $Mob_Overlay


var being_pushed = false
var target

func _ready():
	this_mob = MOB_TYPE.find_key(this_mob)
	overlay.get_node("Panel/Type").text = this_mob
	
func _physics_process(_delta):
	target = get_parent().player
	process_movement()
	
func _process(_delta):
	if mob_dead:
		queue_free()
	if (health <= 0) and (mob_dead == false):
		mob_dead = true
		GameManager.mob_death.emit(this_mob,position)
	if GameManager.devMode:
		overlay.visible = true
	else: 
		overlay.visible = false
		
func process_movement():
	if target:
		var direction = (target.global_position - global_position).normalized()
		if being_pushed:
			velocity = (direction * -1) * 130
		else:
			velocity = direction * speed
		flip_sprite(direction)
		move_and_slide()
	else: 
		print("no player set as target")
		
		
func flip_sprite(direction):
	sprite.set_flip_h(is_player_left(direction))
	sprite.set_flip_v(not is_player_down(direction))


func is_player_left (direction) -> bool:
	if(direction):
		if direction.x < 0:
			return true
		else: return false
	else: return false
	
func is_player_down (direction) -> bool:
	if(direction):
		if direction.y < 0:
			return true
		else: return false
	else: return false

	
func process_damage(damage_amount):
	#print_debug("damage_amount: ",damage_amount)
	#print_debug("damage: ",damage)
	health -= damage_amount
	sprite.material = mob_hurt_shader
	flash_timer.start(flash_duration)
	
func _on_flash_timer_timeout():
	sprite.material = null
