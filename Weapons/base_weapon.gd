extends Node2D
class_name Weapon

@export var impact_damage : float
@export var compound_damage : float
@export var frequency : float
@export var attack_animation : String
var touching_enemies : bool = false

func _ready():
	$Timer.set_wait_time(frequency)

func _process(delta):
	pass

func _on_timer_timeout():
	damage_enemies(compound_damage)
	print("compound damage: ",compound_damage)



func _on_area_2d_body_entered(body):
	$Timer.start(frequency)
	damage_enemies(impact_damage)
	print("impact damage: ",impact_damage)
	
func damage_enemies(current_damage):
	var enemies = $Area2D.get_overlapping_bodies()
	if len(enemies) > 0:
		$AnimatedSprite2D.play(attack_animation)
		for enemy in enemies:
			enemy.set_modulate(Color(0.9608, 0.0745, 0.2627, 1))
			enemy.health -= current_damage
	
	
