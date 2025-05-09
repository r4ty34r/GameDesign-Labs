extends RigidBody2D

# Coordinates
var start_position = Vector2(200, 400)
var hoop_position = Vector2(760, 200)

# Shot properties
@export var shot_power = 700.0  # Adjust this to change shot strength

func _ready():
	# Set up ball
	gravity_scale = 1.0
	
	# Start at the specified position
	global_position = start_position
	
	# Shoot automatically on start
	shoot()


func shoot():
	# Calculate direction to the hoop
	var direction = hoop_position - start_position
	
	# Calculate a good initial velocity to create a parabola
	# We'll use physics formula to calculate the velocity needed
	var distance_x = direction.x
	var distance_y = -direction.y  # Negative because Godot's Y is down
	
	# Calculate shot angle (a good angle for basketball shots)
	var angle = PI / 4  # 45 degrees in radians
	
	# Use the projectile formula to calculate velocity components
	var gravity = 9.8 * gravity_scale * 10  # Scale gravity to match Godot units
	
	# Calculate initial velocity magnitude
	var velocity_x = shot_power * cos(angle)
	var velocity_y = -shot_power * sin(angle)  # Negative because Y is down in Godot
	
	# Apply the impulse
	apply_central_impulse(Vector2(velocity_x, velocity_y))
	
	#
	## Print info for debugging
	print("Shot fired from: ", start_position, " to: ", hoop_position)
	print("Initial velocity: ", Vector2(velocity_x, velocity_y))

func _physics_process(delta):
	 #Print position (for debugging)
	if Engine.get_frames_drawn() % 30 == 0:  # Print every 30 frames
		print("\nBall position: ", global_position)
		print("\nBall linear velo: ", get_linear_velocity())
	if position.x > 1045:
		reset()

func reset():
	global_position = start_position
	linear_velocity = Vector2.ZERO
	angular_velocity = 0
	shoot()
