extends Control
@onready var confirmButton = $UpgradeScreenMargin/VBoxContainer/PanelContainer/VBoxContainer/ConfirmButton
@onready var player = $"../../Player"
@onready var hud = $"../Hud"
@onready var upgrade_slot_1 = $UpgradeScreenMargin/VBoxContainer/PanelContainer/VBoxContainer/MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/Upgrade1
@onready var upgrade_slot_2 = $UpgradeScreenMargin/VBoxContainer/PanelContainer/VBoxContainer/MarginContainer/HBoxContainer/MarginContainer2/VBoxContainer/Upgrade2
@onready var upgrade_label_1 = $UpgradeScreenMargin/VBoxContainer/PanelContainer/VBoxContainer/MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/Label
@onready var upgrade_label_2 = $UpgradeScreenMargin/VBoxContainer/PanelContainer/VBoxContainer/MarginContainer/HBoxContainer/MarginContainer2/VBoxContainer/Label
@onready var upgrade_containers = [upgrade_slot_1,upgrade_slot_2]
@onready var upgrade_labels = [upgrade_label_1,upgrade_label_2]
@onready var upgrades = [null,null]
var damage_upgrade_icon = preload("res://art/icons/saw_blade.png")
var fuel_upgrade_icon = preload("res://art/icons/fuel.webp")
var upgrade_choice = null



func _ready():
	GameManager.connect("lawn_complete",on_lawn_complete)
	populate_upgrades()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
func on_lawn_complete(message):
	GameManager.set_state(GameManager.STATE.UPGRADE)
	visible = true
	GameManager.pause()

func _on_confirm_button_button_down():
	if upgrade_choice != null:
		if upgrade_choice == 'fuel':
			player.max_fuel = player.max_fuel * 1.1
			player.fuel = player.max_fuel
		elif upgrade_choice == 'damage':
			player.weapon.impact_damage += 5
			print("damage increased to ",player.weapon.impact_damage)
			hud.set_damage_label()
		elif upgrade_choice == 'health':
			pass
		if(get_tree().paused == true):
			get_tree().paused = false
			visible = false
		else: 
			print('game not paused')
	else:
		pass
		
		
func populate_upgrades():
	upgrades[0] = (EventManager.get_weighted_upgrade())
	upgrades[1] = (EventManager.get_weighted_upgrade())
	while upgrades[1] == upgrades[0]:
		upgrades[1] = EventManager.get_weighted_upgrade()
	#print(upgrades)
	for i in (upgrades.size()):
		if upgrades[i] == 'fuel':
			upgrade_containers[i].set_texture_normal(fuel_upgrade_icon)
			upgrade_labels[i].text = "+5 Fuel Capacity (Fills Tank)"
		elif upgrades[i] == 'damage':
			upgrade_containers[i].set_texture_normal(damage_upgrade_icon)
			upgrade_labels[i].text = "+1 Impact Damage"
		elif upgrades[i] == 'health':
			pass

func _on_upgrade_1_button_down():
	#print(upgrades[0],' clicked')
	upgrade_choice = upgrades[0]

func _on_upgrade_2_button_down():
	#print(upgrades[1],' clicked')
	upgrade_choice = upgrades[1]
