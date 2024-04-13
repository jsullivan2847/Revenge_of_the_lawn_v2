extends Control
@onready var confirmButton = $MarginContainer/VBoxContainer/PanelContainer/VBoxContainer/ConfirmButton
# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.connect("lawn_complete",on_lawn_complete)
	print(EventManager.get_weighted_upgrade())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
func on_lawn_complete(message):
	GameManager.set_state(GameManager.STATE.UPGRADE)
	visible = true
	GameManager.pause()

func _on_confirm_button_button_down():
	if(get_tree().paused == true):
		get_tree().paused = false
		visible = false
	else: 
		print('game not paused')
