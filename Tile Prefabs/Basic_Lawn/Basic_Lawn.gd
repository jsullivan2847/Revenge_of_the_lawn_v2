extends Area2D
@onready var tilemap = $".."
var cells_in_area
var prev_cells_in_area

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	cells_in_area = tilemap.get_used_cells(1).size() 
	if cells_in_area == 0 and prev_cells_in_area != 0:
		GameManager.lawn_complete.emit("Lawn Complete!")
	prev_cells_in_area = cells_in_area
