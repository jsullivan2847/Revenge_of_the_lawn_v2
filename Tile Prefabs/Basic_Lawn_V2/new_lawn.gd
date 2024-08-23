extends TileMap
@export var min = 45
@export var max = 80

# Called when the node enters the scene tree for the first time.
func _ready():
	#print(get_lawn_cells())
	generate_lawn(get_lawn_cells())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func get_lawn_cells():
	var cells = get_used_cells(1)
	#print_debug('cells: ',cells)
	return cells
	
func get_number_of_cells(min,max,cells):
	#print("cells: ",)
	var min_percent = min * 0.01
	var max_percent = max * 0.01
	#print("min percent: ",min_percent)
	min = cells * min_percent
	max = cells * max_percent
	var number_of_cells_to_erase = RandomNumberGenerator.new().randi_range(min,max)
	return number_of_cells_to_erase
	
func generate_lawn(cells):
	randomize()
	cells.shuffle()
	var number_of_cells_to_erase = get_number_of_cells(min,max,(len(cells) - 1))
	#print_debug('number of cells to erase: ',number_of_cells_to_erase)
	
	
	for i in range(0,number_of_cells_to_erase):
		erase_cell(1,cells[i])
		i+= 1
		
		
	#erase_cell(1,tile_pos)
