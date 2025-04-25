extends "res://addons/gut/test.gd"

func test_fullscreen():
	# Mock Global settings
	Global.fullscreen = false
	var node = preload("res://UI/Options/Options.gd").new()
	#simulate button press
	node._on_fullscreen_toggled(true)
	# Assertions
	assert_eq(Global.fullscreen, true, "Fullscreen should be enabled")
	assert_eq(DisplayServer.window_get_mode(), DisplayServer.WINDOW_MODE_FULLSCREEN, "Game should enter fullscreen")

func test_camera_slider():
	Global.controller_sensitivity = 5
	var node = preload("res://UI/Options/Options.gd").new()
	#simulate value chnage
	node._on_camera_slider_value_changed(3)
	
	assert_eq(Global.controller_sensitivity, 3, "Controller sensitivity should move to the right value")

#WARNING testing AA is not possible becasue you can't create a new viewport in code :(
#func test_antialiasing_btn():
#	#Set AA to off just in case
#	Global.AA_on = false
#	var node = preload("res://UI/Options/Options.gd").new()
#	# simulate button pressed 
#	node._on_antialiasing_toggled(true)
#	#check change
#	assert_eq(Global.AA_on, true, "TAA should be enabled")

func test_music_slider():
	Global.volume_db = -5
	var node = preload("res://UI/Options/Options.gd").new()
	#try change value
	node._on_music_slider_value_changed(-3)
	#check change
	assert_eq(Global.volume_db, -3, "Slider should be new volume value")
