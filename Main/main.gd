extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("space"):
		GameManager.load_game_scene()
		


func _on_touch_screen_button_pressed():
	GameManager.load_game_scene()
