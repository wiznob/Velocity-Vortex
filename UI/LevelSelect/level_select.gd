extends Control

var level_selected = 1
var current_lvl = Global.current_lvl

func _on_lvl_1_pressed():
	level_selected = 1
	if level_selected > current_lvl:
		$Error.text = "You must complete the pervious level"
	else:
		get_tree().change_scene_to_file("res://Levels/Level-1.tscn")

func _on_lvl_2_pressed():
	level_selected = 2
	if level_selected > current_lvl:
		$Error.text = "You must complete the pervious level"
	else:
		pass
		#get_tree().change_scene_to_file("res://Levels/Level-1.tscn")


func _on_lvl_3_pressed():
	level_selected = 3
	if level_selected >= current_lvl:
		$Error.text = "You must complete the pervious level"
	else:
		pass
		#get_tree().change_scene_to_file("res://Levels/Level-1.tscn")
