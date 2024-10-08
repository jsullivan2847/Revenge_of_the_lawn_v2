extends Control

@export var player : CharacterBody2D
@onready var score = $ScreenMargin/ScreenVBox/TopHudHBox/VBoxContainer3/Score
@onready var health_bar = $ScreenMargin/ScreenVBox/TopHudHBox/VBoxContainer/HealthBar
@onready var fuel_bar = $ScreenMargin/ScreenVBox/TopHudHBox/VBoxContainer/FuelBar
@onready var health_label = $ScreenMargin/ScreenVBox/TopHudHBox/VBoxContainer2/HealthValue
@onready var fuel_label = $ScreenMargin/ScreenVBox/TopHudHBox/VBoxContainer2/FuelValue
@onready var message = $ScreenMargin/ScreenVBox/EventMessage
@onready var damage_label = $ScreenMargin/ScreenVBox/StatsMargin/HBoxContainer2/VBoxContainer/ImpactDamageLabel
@onready var lawn_score = $ScreenMargin/ScreenVBox/TopHudHBox/VBoxContainer3/Lawns
var mobs_killed = 0
var lawns_mowed = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	if player:
		player.connect('display_health',set_health_bar)
		player.connect('display_fuel',set_fuel_bar)
		set_damage_label()
	GameManager.connect("mob_death",on_mob_death)
	GameManager.connect("lawn_complete",set_message_one_shot)
	GameManager.connect("lawn_complete",set_lawn_score)
	set_message_one_shot("Mow Lawns to Win Upgrades!!!")

func _process(_delta):
	pass

func on_mob_death(mob_type,mob_position):
	mobs_killed += 1
	score.text = "Kills: " + str(mobs_killed)
	
func set_health_bar():
	health_bar.value = player.health
	health_label.text = str(player.health) + " / " + str(player.max_health)

func set_fuel_bar():
	fuel_bar.value = player.fuel
	fuel_label.text = str(int(player.fuel)) + " / " + str(int(player.max_fuel))
	
func set_damage_label():
	damage_label.text = str(player.weapon.impact_damage)
	
func set_lawn_score(text):
	lawns_mowed += 1
	lawn_score.text = "Lawns: " + str(lawns_mowed)
	
func set_message_one_shot(text):
	if(message):
		message.set_modulate(Color(1,1,1,1))
		message.text = text
		var tween = get_tree().create_tween()
		tween.tween_property(message, "modulate", Color(1,1,1,0), 2)
