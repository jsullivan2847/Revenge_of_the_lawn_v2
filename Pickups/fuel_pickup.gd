extends Pickup

@export var fuel : int
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func pickup_effect():
	if(player.fuel < player.max_fuel):
		visible = false
		player.fuel += fuel
		AudioManager.play_clip($Pickup,AudioManager.PICKUP_SOUND)
