extends Node2D
class_name Weapon

@export var impact_damage : float
@export var compound_damage : float
@export var frequency : float
@export var attack_animation : String
@export var impact_sound : String
@onready var mob_hurt_shader = preload("res://Mobs/mob_hurt_material.tres")
var enemies = []
var tiles = []

func _ready():
	$dmg_freq_timer.set_wait_time(frequency)

func _process(_delta):
	pass

func _on_timer_timeout():
	damage_enemies(compound_damage)



func _on_area_2d_body_entered(body):
	if body.is_in_group("Mob"):
		body.being_pushed = true
		damage_enemies(impact_damage)
		$dmg_freq_timer.start(frequency)
		if(impact_sound):
			AudioManager.play_clip($"Weapon Sound",impact_sound)
		#print("impact damage: ",impact_damage)
		
func _on_area_2d_body_exited(body):
	if body.is_in_group("Mob"):
		body.being_pushed = false
	
func damage_enemies(current_damage):
	enemies = $Area2D.get_overlapping_bodies().filter(func (body): return body.is_in_group("Mob"))
	tiles = $Area2D.get_overlapping_bodies().filter(func (body): return body.is_in_group("Tiles"))
	if len(enemies) > 0:
			$AnimatedSprite2D.play(attack_animation)
			for enemy in enemies:
				enemy.process_damage(current_damage)


func _on_tile_collider_body_entered(body):
	tile_collision_processing($TileCollider,body)
	
func tile_collision_processing(collider,body):
	print('hit: ',body)
	var tile_pos = body.local_to_map(body.to_local(collider.global_position))
	#print("cell atlas coords: ",body.get_cell_atlas_coords(0,tile_pos,false))
	body.erase_cell(1,tile_pos)
	#body.set_cell(0,tile_pos,0,Vector2(0,7))
	
