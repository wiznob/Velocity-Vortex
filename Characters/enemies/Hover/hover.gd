extends CharacterBody3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_hurt_box_area_entered(area):
	if area.is_in_group("player") or area.is_in_group("bothSides"):
		print("I've been hit")

func _on_attack_mode_timeout():
	$AttackBox/AttackShape.disabled = false
	$IdleMode.start()

func _on_idle_mode_timeout():
	$AttackBox/AttackShape.disabled = true
	$AttackMode.start()
