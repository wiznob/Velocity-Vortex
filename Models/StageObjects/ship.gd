extends Node3D




func _on_area_3d_body_entered(body):
	$AudioStreamPlayer3D.play()
