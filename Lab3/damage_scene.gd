extends Area2D

@onready var playerNode = get_node("../player")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#set it to be middle of the screen and falling down 
	position.x = 500
	position.y = 50
	print("player node is: ", playerNode, "\n")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += 8
	
	if position.y >=500:
		position.y = 0


func _on_body_entered(body):
	if body.has_method("takeDamage"):
		var original_color = body.modulate
		body.modulate = Color(1,0,0)
		await get_tree().create_timer(0.2).timeout
		var currentHealth: float = body.takeDamage()
		body.modulate = original_color
		if currentHealth < 90:
			body.die()

	#if playerNode.health < 90:
		#body.respawn()
