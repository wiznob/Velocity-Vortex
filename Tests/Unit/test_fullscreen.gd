extends  GutTest
var options = load("res://UI/Options/Options.gd")
#example of a test
func test_fullscreen():
	var _options = options.new()
	options._on_fullscreen_toggled()
	var result = DisplayServer.window_get_mode()
	assert_eq(result, 3)
func test_windoed():
	var _options = options.new()
	options._on_fullscreen_toggled()
	var result = DisplayServer.window_get_mode()
	assert_eq(result, 0)
