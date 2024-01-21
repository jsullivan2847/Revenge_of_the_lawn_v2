extends Control


func _ready():
	pass 


func _process(_delta):
	if(Input.is_action_just_pressed("space")):
		GameManager.on_game_over()
