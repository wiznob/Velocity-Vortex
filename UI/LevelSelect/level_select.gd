extends Control

var level_selected = 1
var current_lvl = Global.current_lvl
var error_text = "You must complete the previous level."

func _on_lvl_1_pressed():
	level_selected = 1
	if level_selected > current_lvl:
		$Error.text = error_text
	else:
		get_tree().change_scene_to_file("res://Levels/Level-1.tscn")
		Global.Leaderboard = "level-1"

func _on_lvl_2_pressed():
	level_selected = 2
	if level_selected > current_lvl:
		$Error.text = error_text
	else:
		get_tree().change_scene_to_file("res://Levels/Level-2.tscn")
		Global.Leaderboard = "level-2"

func _on_lvl_3_pressed():
	level_selected = 3
	if level_selected > current_lvl:
		$Error.text = error_text
	else:
		Global.Leaderboard = "level-3"
		get_tree().change_scene_to_file("res://Levels/Level-3.tscn")

func _on_back_pressed():
	get_tree().change_scene_to_file("res://UI/MainMenu.tscn")
