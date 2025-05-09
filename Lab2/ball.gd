extends Area2D

@export var velocity : Vector2


var trail_positions = []
var trail_timer = 0
var trail_interval = 0.1  # Create a trail point every 0.1 seconds

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	trail_timer += delta
	if trail_timer >= trail_interval:
		trail_timer = 0
		create_trail_at_current_position()
	
	
	position += velocity   # Move the ball

	# Bounce off top and bottom walls
	if position.y <= 1 or position.y >= get_viewport_rect().size.y-1:
		velocity.y = -velocity.y
	
	# if off screen
	#if position.y > get_viewport_rect().size.y or position.y < -1 or position.x > get_viewport_rect().size.x+1 or position.x < -1:
		#spawn()

func create_trail_at_current_position():
	var trail = preload("res://TrailSegment.tscn").instantiate()
	 # Calculate position behind the ball based on its current velocity
	var direction = -velocity.normalized()  # Opposite of movement direction
	var offset_distance = 100  # Pixels behind the ball (adjust based on ball size)
	
	trail.position = position + (direction * offset_distance)
	trail.modulate = Color(1,0,0,0.8)
	get_parent().add_child(trail)
	var tween = get_tree().create_tween()
	tween.tween_property(trail, "modulate", Color(1,0,0,0), 1.0)
	tween.tween_callback(Callable(trail, "queue_free"))
	


func _on_area_entered(area):
	if area.is_in_group("paddle"):
		# Simple top/bottom half detection
		var paddle_center_y = area.global_position.y
		
		# Horizontal direction always reverses
		velocity.x = -velocity.x
		
		# Set vertical direction based on which half of the paddle was hit
		if global_position.y < paddle_center_y:
			# Hit top half - go up at approximately 45 degrees
			velocity.y = -abs(velocity.x)
		else:
			# Hit bottom half - go down at approximately 45 degrees
			velocity.y = abs(velocity.x)
		
		# Nudge ball away from paddle to prevent sticking
		global_position.x += sign(velocity.x) * 5
	elif area.is_in_group("trail_segments"):
		# Bounce off trail segments
		velocity = velocity.bounce(Vector2(-sign(velocity.x), 0))
	
func spawn():
	position = get_viewport_rect().size/2
	velocity = Vector2(randf_range(-5,5), randf_range(-5,5))


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("trail"):
		#bounce_from_trail(body)
		velocity *= -1
		

func bounce_from_trail(trail):
	#var direction_to_trail = (trail.position - position).normalized()
	#
	#velocity = velocity.bounce(-direction_to_trail)
	velocity *= -1
	
	
