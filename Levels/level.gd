extends Node3D

func _on_goal_goal_entred():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$GoalUI.visible = true
	get_tree().paused = true
	
	
