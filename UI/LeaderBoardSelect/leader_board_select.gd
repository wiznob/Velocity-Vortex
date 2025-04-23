extends Control

func _on_lvl_1_pressed():
		Global.Leaderboard = "level-1"
		get_tree().change_scene_to_file("res://UI/leaderboard/NewLeaderboard.tscn")

func _on_lvl_2_pressed():
		Global.Leaderboard = "level-2"
		get_tree().change_scene_to_file("res://UI/leaderboard/NewLeaderboard.tscn")

func _on_lvl_3_pressed():
		Global.Leaderboard = "level-3"
		get_tree().change_scene_to_file("res://UI/leaderboard/NewLeaderboard.tscn")

func _on_back_pressed():
	get_tree().change_scene_to_file("res://UI/MainMenu.tscn")
