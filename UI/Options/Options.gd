extends Node

func _ready():
	$MarginContainer/VBoxContainer/CameraSlider.value = Global.controller_sensitivity
	$MarginContainer/VBoxContainer/MusicSlider.value = Global.volume_db
	if Global.fullscreen == true:
		$MarginContainer/VBoxContainer/Fullscreen.button_pressed = true
	else:
		$MarginContainer/VBoxContainer/Fullscreen.button_pressed = false
	
	if Global.AA_on == true:
		$"MarginContainer/VBoxContainer/anti-aliasing".button_pressed = true
	else:
		$"MarginContainer/VBoxContainer/anti-aliasing".button_pressed = false
	$MarginContainer/VBoxContainer/CameraSlider.value = Global.controller_sensitivity

func _on_back_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://UI/MainMenu.tscn")
	Global.save_game()

#Fullscreen toggle
func _on_fullscreen_toggled(toggled_on):
	if toggled_on == true:
		Global.fullscreen = true 
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		Global.fullscreen = false
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_camera_slider_value_changed(value):
	Global.controller_sensitivity = value

func _on_antialiasing_toggled(toggled_on):
	var viewport = get_viewport()
	if toggled_on == true:
		Global.AA_on = true
		RenderingServer.viewport_set_use_taa(viewport.get_viewport_rid(), true)
	else:
		Global.AA_on = false
		RenderingServer.viewport_set_use_taa(viewport.get_viewport_rid(), false)
	
func _on_music_box_toggled(toggled_on):
	if toggled_on == true:
		Global.audio_player.play()
	else:
		Global.audio_player.stop()

func _on_music_slider_value_changed(value):
	Global.set_volume(value)


func _on_button_pressed():
	Global.reset_save()
