extends Control
#Main code used by menus
#@author W.O September 2024
var player_name
var final_time

#Start of main menu
func _on_play_pressed():
	get_tree().change_scene_to_file("res://Levels/Level-1.tscn")

func _on_options_pressed():
	get_tree().change_scene_to_file("res://UI/Options/Options.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_leaderboard_pressed():
	get_tree().change_scene_to_file("res://UI/leaderboard/NewLeaderboard.tscn")
#end of main menu

#start of goalUI
func _on_submit_pressed():
	if $LineEdit.text != "":
		player_name = $LineEdit.text
		get_tree().paused = false
		SilentWolf.Scores.save_score(player_name, final_time)
		get_tree().change_scene_to_file("res://UI/leaderboard/NewLeaderboard.tscn")

func _on_skip_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://UI/MainMenu.tscn")

func _on_visibility_changed():
	var dash_ui_scene = get_node("../../Dash/DashUI")
	final_time = dash_ui_scene.get("total_time")
	$VBoxContainer/Submit.grab_focus()
#End of GoalUI
