extends Node

var main_scene : PackedScene = preload("res://Main/main.tscn") 
var game_scene : PackedScene = preload("res://Game/game.tscn")
var game_over_scene : PackedScene = preload("res://Game Over/GameOver.tscn")
# Called when the node enters the scene tree for the first time.

var STATE = {PLAYING="playing",PAUSED="paused",GAMEOVER="gameover",UPGRADE="upgrade",CUTSCENE="cutscene"}
var current_state = STATE.PLAYING
signal mob_death(mob_type,mob_position)
signal player_moving(speed)
signal lawn_complete(message)

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func on_game_over():
	get_tree().change_scene_to_packed(game_over_scene)
func load_game_scene():
	get_tree().change_scene_to_packed(game_scene)
func pause():
	get_tree().paused = true
	
func get_state():
	return current_state
	
func set_state(new_state):
	if current_state != new_state:
		current_state = new_state
		print('state set to ',current_state)
	else:
		print('state is already that')
