extends Area3D

func _ready():
	var dash_ui_scene = get_node("../../Dash/DashUI")
	var coin_label = dash_ui_scene.get_node("coinLabel")
	coin_label.text = "Coins: " + str(Global.coins)

func _on_body_entered(body):
	if body.name == "Dash":
		var dash_ui_scene = get_node("../../Dash/DashUI")
		var coin_label = dash_ui_scene.get_node("coinLabel")
		Global.coins += 1
		coin_label.text = "Coins: " + str(Global.coins)
		queue_free()
