extends Node2D

@export var speed = 200
@export var health = 50
@export var interpolation_factor : float = 0.1
@export var rotation_offset : int = 0
@export var joystick_left : VirtualJoystick
@export var joystick_right : VirtualJoystick

signal _on_Enemy_body_entered(body: Node)
var move_vector := Vector2.ZERO


func _ready():
	pass
	
func _process(delta: float) -> void:
	process_joystick(delta)

		
func process_joystick(delta):
	if joystick_left and joystick_left.is_pressed:
		position += joystick_left.output * speed * delta
		
	if joystick_right and joystick_right.is_pressed:
		var new_rotation = (rad_to_deg(joystick_right.output.angle()) + rotation_offset)
		if rotation_degrees < -90 and new_rotation > 0:
			rotation_degrees = new_rotation
		if rotation_degrees > 10 and new_rotation < 0:
			rotation_degrees = new_rotation
		rotation_degrees = lerp(rotation_degrees, new_rotation, interpolation_factor)
	
