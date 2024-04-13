extends Sprite2D

@onready var shader_material = preload("res://art/grass/erase_shader.tres")
@export var player : CharacterBody2D

func _ready():
	shader_material = shader_material.duplicate()
	material = shader_material
	#shader_material.set_shader_parameter("mask_radius", 0.1)

func _process(_delta):
	material.set_shader_parameter("mask_center", player.global_position)
	
	#print("mask center: ",material.get_shader_parameter("mask_center"))
	#print("mask radius: ",material.get_shader_parameter("mask_radius"))
