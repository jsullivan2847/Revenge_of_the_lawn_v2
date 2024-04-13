extends Control
@onready var confirmButton = $MarginContainer/VBoxContainer/PanelContainer/VBoxContainer/ConfirmButton
@onready var player = $"../../Player"
@onready var upgrade_slot_1 = $MarginContainer/VBoxContainer/PanelContainer/VBoxContainer/MarginContainer/HBoxContainer/MarginContainer/Upgrade1
@onready var upgrade_slot_2 = $MarginContainer/VBoxContainer/PanelContainer/VBoxContainer/MarginContainer/HBoxContainer/MarginContainer2/Upgrade2
@onready var upgrade_containers = [upgrade_slot_1,upgrade_slot_2]
@onready var upgrades = [null,null]
var damage_upgrade_icon = preload("res://art/icons/saw_blade.png")
var fuel_upgrade_icon = preload("res://art/icons/fuel.webp")
var upgrade_choice = null



func _ready():
	GameManager.connect("lawn_complete",on_lawn_complete)
	populate_upgrades()
	#print(EventManager.get_weighted_upgrade())
	#print(player.weapon.impact_damage)

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
		
func populate_upgrades():
	upgrades[0] = (EventManager.get_weighted_upgrade())
	upgrades[1] = (EventManager.get_weighted_upgrade())
	while upgrades[1] == upgrades[0]:
		upgrades[1] = EventManager.get_weighted_upgrade()
	for i in (upgrades.size()):
		if upgrades[i] == 'fuel':
			upgrade_containers[i].set_texture_normal(fuel_upgrade_icon)
		elif upgrades[i] == 'damage':
			upgrade_containers[i].set_texture_normal(damage_upgrade_icon)
		elif upgrades[i] == 'health':
			pass

func _on_upgrade_1_button_down():
	print(upgrades[0])


func _on_upgrade_2_button_down():
	print(upgrades[1])
