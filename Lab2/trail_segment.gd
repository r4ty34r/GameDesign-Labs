extends StaticBody2D

# How long this trail segment will exist before disappearing
@export var lifetime = 10.0
var time_alive: float = 0.0


# Optional: make trails weaken over time
@export var weakens_over_time = true

func _ready():
	# You can modify the trail's appearance based on game state
	# For example, different colors based on which player hit last
	modulate = Color(1, 0.5, 0.2, 0.8)  # Orange-ish with some transparency
	
	# Set up initial scale
	scale = Vector2(1, 1)

func _process(delta):
	time_alive += delta
	
	if weakens_over_time:
		# Gradually decrease opacity
		modulate.a = 0.8 * (1 - (time_alive / lifetime))
		
		# Optional: also shrink the collision shape over time
		var new_scale = 1 - (time_alive / lifetime)
		scale = Vector2(new_scale, new_scale)
	
	# Remove when lifetime is exceeded
	if time_alive >= lifetime:
		queue_free()
