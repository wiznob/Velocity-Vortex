extends Node3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func play_idle():
	$AnimationPlayer.play("Idle")
func play_jump():
	$AnimationPlayer.play("Jump")
func play_jog():
	$AnimationPlayer.play("Jog")
func play_run():
	$AnimationPlayer.play("Run")
func play_death():
	$AnimationPlayer.play("Death")
func play_attack():
	$AnimationPlayer.play("Attack")
