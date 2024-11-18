extends Node


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
