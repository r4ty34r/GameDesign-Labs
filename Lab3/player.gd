extends CharacterBody2D


const SPEED = 300.0*5
const JUMP_VELOCITY = -600.0

@export var health: float = 100.0
@export var damageAmount: float = 2.0

@onready var damageNode = get_node("../Area2D")

@export var respawnPosition: Vector2
func _ready() -> void:
	#set global to top right corner
	
	print("damageNode path is: ", damageNode)
	respawnPosition = global_position
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	#
	# cal explode from main
	#if health < 95: 
		#explode()
 #

func takeDamage() -> float:
	print("health was: ", health, " and is now: ")
	health -= damageAmount
	print(health, "\n")
	return health
	
#
#func explode() -> void:
	#self.global_scale += Vector2(0.1,0.1)
	#
#func repsawn() -> void:
	#position.x = 500
	#position.y = 600
	#self.global_scale = Vector2(0,0)

func die():
	global_position = respawnPosition
