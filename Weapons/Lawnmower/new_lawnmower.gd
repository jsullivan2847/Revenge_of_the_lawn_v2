extends Weapon

# Called when the node enters the scene tree for the first time.
func _ready():
	if(impact_sound == 'LAWNMOWER_IMPACT'):
		impact_sound = AudioManager.LAWNMOWER_IMPACT
	super._ready()
	AudioManager.play_clip($Start,AudioManager.LAWNMOWER_START)
	AudioManager.play_clip($Loop,AudioManager.LAWNMOWER_LOOP)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	

func _on_tile_collider_2_body_entered(body):
	tile_collision_processing($TileCollider2,body)
	
func _on_tile_collider_3_body_entered(body):
	tile_collision_processing($TileCollider3,body)
	
func _on_tile_collider_4_body_entered(body):
	tile_collision_processing($TileCollider4,body)
