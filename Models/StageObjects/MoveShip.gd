extends Node3D

var move = false
@onready var player = $"../../../Dash"
func _process(delta):
	if move == true:
		translate(Vector3(-5, 0, 0) * delta)
		if player:
			player.translate(Vector3(0 ,0 ,0 ) * delta)
	else:
		pass

func _on_area_3d_body_entered(body):
	move = true
