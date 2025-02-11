extends Node3D
signal goal_entred 

func _on_area_3d_body_entered(body):
	if body.name == "Dash":
		goal_entred.emit()
