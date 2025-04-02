extends Node3D
#Code used for High level functions in a stage
#@author W.O
#November 2024

#Boundary
func _ready():
	Global.Leaderboard = "level-1"
func _on_body_entered(body):# Death plane
	if body.name == "Dash":
		var death_node = get_node("../Death")
		if death_node != null:
			death_node._out_of_bounds()
		else:
			print("Death node not found!")
	else:
		body.queue_free()

func goal_entred(): # When the player gets within goal range
	Global.current_lvl = 2
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$Goal/GoalUI.visible = true
	get_tree().paused = true
