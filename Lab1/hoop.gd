extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_key_label_pressed(KEY_W):
		position.y -= 10
	if Input.is_key_label_pressed(KEY_S):
		position.y += 10
	
	if Input.is_key_label_pressed(KEY_A):
		position.x -= 1

	if Input.is_key_label_pressed(KEY_D):
		position.x += 1

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("ball"):
		print("score!\n")
		body.reset()
	elif  body.is_in_group("boundary"):
		position.y = body.position.y
		
