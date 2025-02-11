extends Node


func _on_back_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://UI/MainMenu.tscn")

#Fullscreen toggle
func _on_fullscreen_toggled(toggled_on):
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
