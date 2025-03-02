extends Control

func _on_quit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://UI/MainMenu.tscn")

func _on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	visible = false


func _on_dash_i_am_dead():
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		visible = true
		get_tree().paused = true
		$VBoxContainer/Restart.grab_focus()

func _out_of_bounds():
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		visible = true
		get_tree().paused = true
		$VBoxContainer/Restart.grab_focus()
