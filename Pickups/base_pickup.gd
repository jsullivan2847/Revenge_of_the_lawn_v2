extends Node2D
class_name Pickup

var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group('player'):
		player = body
		pickup_effect()
		
func pickup_effect():
	print_debug('no pickup effect defined in class extension')


func _on_pickup_finished():
	queue_free()
