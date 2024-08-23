extends Area2D
@onready var tilemap = $".."
var cells_in_area
var prev_cells_in_area

# Called when the node enters the scene tree for the first time.
func _ready():
	#print_debug(GameManager.get_signal_list())
	#GameManager.connect(lawn_complete,reload_lawn())
	cells_in_area = tilemap.get_used_cells(1).size() 
	#print_debug(tilemap.get_layer_name(1))
	#print_debug(cells_in_area)
	
func reload_lawn():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	cells_in_area = tilemap.get_used_cells(1).size() 
	if cells_in_area == 0 and prev_cells_in_area != 0:
		GameManager.lawn_complete.emit("Lawn Complete!")
	prev_cells_in_area = cells_in_area
