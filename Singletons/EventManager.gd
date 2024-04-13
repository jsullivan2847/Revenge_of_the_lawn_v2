extends Node

@onready var rng = RandomNumberGenerator.new()

# Preload pickup scenes and assign weights
var health_pickup_scene = preload("res://Pickups/health_pickup.tscn")
var fuel_pickup_scene = preload("res://Pickups/fuel_pickup.tscn")

#0 index is the pickup, 1 index is 1 in X chance of it dropping.
#The higher the number the rarer the item will be
var pickups = {
	'Health': [health_pickup_scene, 2],
	'Fuel': [fuel_pickup_scene, 10],
}

#var upgrades = {
	#'Damage': [damage_upgrade_scene, 1],
	#'Health': [health_upgrade_scene, 1],
	#'Fuel': [fuel_upgrade_scene, 1]
#}

# Precompute cumulative weights for the weighted selection
var cumulative_weights = []
var total_weight = 0

func calculate_element_weight():
	cumulative_weights = []
	total_weight = 0
	for pickup in pickups.values():
		var weight = pickup[1]
		total_weight += weight
		cumulative_weights.append(total_weight)
	return [total_weight,cumulative_weights]

func _ready():
	GameManager.mob_death.connect(drop_pickup)

func drop_pickup(mob_type, mob_position):
	if mob_type == 'test':
		pass
	if rng.randi_range(1, 100) <= 25: # 25% chance to drop a pickup
		var pickup_scene = select_weighted_pickup(calculate_element_weight())
		if pickup_scene != null:
			var pickup = pickup_scene.instantiate()
			var root = get_node('/root/Game')
			root.add_child(pickup)
			pickup.position = mob_position

# Function to select a pickup based on weighted probabilities
func select_weighted_pickup(weights):
	total_weight = weights[0]
	cumulative_weights = weights[1]
	print('total_weight: ',total_weight)
	print('cumulative_weights: ',cumulative_weights)
	var rand_int = rng.randi_range(0, total_weight - 1)
	for i in range(pickups.size()):
		if rand_int < cumulative_weights[i]:
			return pickups.values()[i][0]
	return null
