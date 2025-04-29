extends Node

var volume_db = 0
var coins = 0
var AA_on = false
var fullscreen = false
var current_lvl = 1
var Leaderboard = "main"
var audio_player = AudioStreamPlayer.new()
@export_range(0.0, 3.0) var controller_sensitivity := 3.00

func _ready():
	SilentWolf.configure({
		"api_key": "JQOWhN1Kvu37gURgTZwYZ4R1m96EwqPba2ZwCING",
		"game_id": "VelocityVortex",
		"log_level": 1
	})
	SilentWolf.configure_scores({
		"open_scene_on_close": "res://UI/MainMenu.tscn"
	})

	add_child(audio_player)
	audio_player.stream = preload("res://audio/music.mp3")
	audio_player.play()
	
	load_game()
	audio_player.volume_db = volume_db
	audio_player.play()
	audio_player.finished.connect(_on_audio_end)
	
func _on_audio_end():
	audio_player.play()

func set_volume(new_volume):
	volume_db = new_volume
	audio_player.volume_db = volume_db  # Adjust the volume

func save_game():
	var config = ConfigFile.new()
	config.set_value("SaveData", "coins", coins)
	config.set_value("SaveData", "current_lvl", current_lvl)
	config.set_value("SaveData", "volume_db", volume_db)
	config.set_value("SaveData", "controller_sensitivity", controller_sensitivity)
	
	# Save file to user directory
	var error = config.save("user://savegame.cfg")
	if error != OK:
		print("Error saving game: ", error)

func load_game():
	var config = ConfigFile.new()
	
	# Check if the save exists and load it
	if config.load("user://savegame.cfg") == OK:
		coins = config.get_value("SaveData", "coins", 0)
		current_lvl = config.get_value("SaveData", "current_lvl", 1)
		volume_db = config.get_value("SaveData", "volume_db", 0)
		controller_sensitivity = config.get_value("SaveData", "controller_sensitivity", 3.00)
	else:
		print("No save file found, starting with default settings.")

func reset_save():
	coins = 0
	current_lvl = 1
	save_game()
	load_game()

# automatically save when about to quit:
func _notification(uhoh):
	if uhoh == NOTIFICATION_WM_CLOSE_REQUEST:
		save_game()
