extends TileMap
@export var minimum_cells_to_erase = 190
@export var maximum_cells_to_erase = 210

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_lawn(get_lawn_cells())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func get_lawn_cells():
	var cells = get_used_cells(1)
	#print_debug('cells: ',cells)
	return cells

func generate_lawn(cells):
	randomize()
	cells.shuffle()
	var number_of_cells_to_erase = RandomNumberGenerator.new().randi_range(minimum_cells_to_erase,maximum_cells_to_erase)
	#print_debug('number of cells to erase: ',number_of_cells_to_erase)
	for i in range(0,number_of_cells_to_erase):
		erase_cell(1,cells[i])
		i+= 1
	#erase_cell(1,tile_pos)
