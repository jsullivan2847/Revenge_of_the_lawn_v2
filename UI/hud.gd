extends Control

@export var player : CharacterBody2D
var mobs_killed = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	set_health_bar()
	set_fuel_bar()
	player.connect('display_health',set_health_bar)
	player.connect('display_fuel',set_fuel_bar)
	SignalManager.connect("mob_death",on_mob_death)
	SignalManager.connect("lawn_complete",set_message_one_shot)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

	
func on_mob_death(mob_type,mob_position):
	mobs_killed += 1
	$Score.text = "Score: " + str(mobs_killed)
	
func set_health_bar():
	$HealthBar.value = player.health

func set_fuel_bar():
	$FuelBar.value = player.fuel
	
func set_message_one_shot(text):
	$Message.set_modulate(Color(1,1,1,1))
	$Message.text = text
	var tween = get_tree().create_tween()
	tween.tween_property($Message, "modulate", Color(1,1,1,0), 2)
	#$message_fadeout.start(2)
	
#func _on_message_fadeout_timeout():
	#print($Message.label_settings.font_color.a)
