extends Node3D

func _on_goal_goal_entred():
	pass

func _on_body_entered(body):
	get_tree().reload_current_scene()

func goal_entred():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$Goal/GoalUI.visible = true
	get_tree().paused = true

func _physics_process(delta):
	var pause = Input.is_action_just_pressed("pause")
	if pause == true:
		get_tree().paused = true
		$Options.visible = true
	
