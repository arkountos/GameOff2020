extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var tile_size = get_cell_size()
var half_tile_size = tile_size / 2

var grid_size = Vector2(50, 50)
var grid = []


#onready var Obstacle = preload("res://icon.png")


# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)
			
	var MyKinematicBody2D = get_parent().get_node("Player/KinematicBody2D")
	var start_pos = update_child_pos(MyKinematicBody2D)
	MyKinematicBody2D.set_position(start_pos)
	print("Done in grid_ready")
	

func is_cell_vacant(pos, direction):
	# Return true if cell is vacant
	var grid_pos = world_to_map(pos) + direction
	# TODO: Check for grid borders!
	if (grid[grid_pos.x][grid_pos.y] == null):
		return true
	else:
		return false
		
func update_child_pos(child_node):
	# Move a child to a new position and update the grid
	var grid_pos = world_to_map(child_node.get_position())
#	print(grid_pos)
	# The cell where the player was is now empty
	grid[grid_pos.x][grid_pos.y] = null
	
	var new_grid_pos = grid_pos + child_node.direction
#	grid[grid_pos.x][grid_pos.y] = child_node.type
	var target_pos = map_to_world(new_grid_pos)
#	Not needed without "Centered" attribute checked on Sprite! # + half_tile_size
	print("update_child returns: ", target_pos)
	return target_pos
	
	


		
		
		
