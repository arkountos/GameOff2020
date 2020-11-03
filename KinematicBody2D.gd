extends KinematicBody2D

export var speed = 0
var direction = Vector2()
var velocity = Vector2()

var RIGHT = Vector2(1, 0)
var LEFT = Vector2(-1, 0)
var UP = Vector2(0, -1)
var DOWN = Vector2(0, 1)

export var MAX_SPEED = 200

var is_moving = false
var target_pos = Vector2()
var target_dir = Vector2()

# Ugh.
onready var grid = get_parent().get_parent().get_node("TileMap")

# Called when the node enters the scene tree for the first time.
func _ready():
	
#	var grid = get_node("/root/GameScene/TileMap")
	set_physics_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	direction = Vector2()
#	speed = MAX_SPEED

	if Input.is_action_pressed("left"):
		direction = LEFT
	elif Input.is_action_pressed("right"):
		direction = RIGHT
	elif Input.is_action_pressed("up"):
		direction = UP
	elif Input.is_action_pressed("down"):
		direction = DOWN
#	print("direction = " , direction)
	if not is_moving and direction != Vector2():
		target_dir = direction
		if grid.is_cell_vacant(get_position(), target_dir):
			target_pos = grid.update_child_pos(self)
			is_moving = true
			print("in first if, target_pos is: ", target_pos)
	elif is_moving:
		speed = MAX_SPEED
		velocity = speed * target_dir
		print("velocity: ", velocity)
		
		var pos = get_position()
		var distance_to_target = Vector2(abs(target_pos.x - pos.x), abs(target_pos.y - pos.y))
		
		if abs(velocity.x) > distance_to_target.x:
#			print("in here")
			velocity.x = distance_to_target.x * target_dir.x
			is_moving = false
		if abs(velocity.y) > distance_to_target.y:
			velocity.y = distance_to_target.y * target_dir.y
			is_moving = false
		print("velocity.x, distance_to_target.x, target_dir.x: ", velocity.x, " ", distance_to_target.x, " ",  target_dir.x)
		print("velocity after distance measuring: ", velocity)
		var collision = move_and_collide(velocity)
		print("collision: ", collision)
		if collision:
			# Stay in your tile
			pass
#			print("collider name", collision.collider_id)
#			target_dir = -target_dir
#			target_pos = get_position()
#			velocity = Vector2()
			
		
#	var target_pos = grid.update_child_pos(self)
#	set_position(target_pos)

