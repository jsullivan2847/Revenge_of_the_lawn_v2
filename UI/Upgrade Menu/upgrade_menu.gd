extends Control
@onready var confirmButton = $MarginContainer/VBoxContainer/PanelContainer/VBoxContainer/ConfirmButton
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_confirm_button_button_down():
	print("pressed")
