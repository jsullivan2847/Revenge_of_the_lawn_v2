extends Node2D
@export var mob : PackedScene
@export var frequency : float = 2.0
@onready var timer = $SpawnFrequency
@export var player : CharacterBody2D
var origin = null
var spawnArea = null
var spawnShape = null
# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = 4
	spawnShape = player.get_node('SpawnArea').get_node('Circle')
	spawnArea = spawnShape.get_shape().radius
	timer.wait_time = frequency

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_spawn_frequency_timeout():
	var new_mob = mob.instantiate()
	add_child(new_mob)
	new_mob.position = gen_random_pos()


func gen_random_pos():
	origin = spawnShape.global_position - Vector2(spawnArea, spawnArea)
	if origin:
		var x = randf_range(origin.x, origin.x + spawnArea * 2)
		var y = randf_range(origin.y, origin.y + spawnArea * 2)
	
		return Vector2(x, y)
	return
	

	
	

