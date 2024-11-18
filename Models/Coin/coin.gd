extends Area3D

var coins = 0

func _on_body_entered(body):
	var dash_ui_scene = get_node("../Dash/DashUI")
	var coin_label = dash_ui_scene.get_node("coinLabel")
	if body.name == "Dash":
		coins += 1
		coin_label.text = "Coins: " + str(coins)
		queue_free()
