extends Control

@export var player : CharacterBody2D
@onready var health_display = $MarginContainer/Health
# Called when the node enters the scene tree for the first time.
func _ready():
	health_display.text = str(player.health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_display_health():
	health_display.text = str(player.health)
