extends Node

var audio_player
var volume_db = 0
var coins = 0
var AA_on = false
var fullscreen = false
var current_lvl = 1
var Leaderboard = "main"
@export_range(0.0, 3.0) var controller_sensitivity := 3.00
# Called when the node enters the scene tree for the first time.
func _ready():
	SilentWolf.configure({
	"api_key": "JQOWhN1Kvu37gURgTZwYZ4R1m96EwqPba2ZwCING",
	"game_id": "VelocityVortex",
	"log_level": 1
	  })
	SilentWolf.configure_scores({
	"open_scene_on_close": "res://UI/MainMenu.tscn"
  })
	audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	audio_player.stream = preload("res://audio/test-audio.mp3")
	audio_player.play()
	
func set_volume(new_volume):
	volume_db = new_volume
	audio_player.volume_db = volume_db  # Adjust the volume
