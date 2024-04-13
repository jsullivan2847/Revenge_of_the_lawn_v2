extends Node

var pickups = {
	'Health': preload("res://Pickups/health_pickup.tscn"),
	'Fuel': preload("res://Pickups/fuel_pickup.tscn"),
	'Fuel_2': preload("res://Pickups/fuel_pickup.tscn"),
}

func _ready():
	GameManager.mob_death.connect(drop_pickup)
	#GameManager.lawn_complete.connect(upgrade)
	
func _process(_delta):
	pass
	
func drop_pickup(mob_type,mob_position):
	if (mob_type == 'test'):
		#do something
		pass
	var rng = RandomNumberGenerator.new()
	var rand_int = rng.randi_range(0, 18)
	if rand_int >= 0 and rand_int < pickups.size():
		var pickup = pickups.values()[rand_int].instantiate()
		var root = get_node('/root/Game')
		root.add_child(pickup)
		pickup.position = mob_position
	#if(target.health < target.max_health):
		#var pickup = health_pickup.instantiate()
		#Game.add_child(pickup)
		#pickup.position = position
#func upgrade(text):
	#print(text)
	#GameManager.pause()

