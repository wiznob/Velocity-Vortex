extends Node3D
#Code used for High level functions in a stage
#@author W.O
#November 2024
func _on_goal_goal_entred():
	pass

#Boundary
func _on_body_entered(body):# Death plane
	if body.name == "Dash":
		get_tree().reload_current_scene()

func goal_entred(): # When the player gets within goal range
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$Goal/GoalUI.visible = true
	get_tree().paused = true
