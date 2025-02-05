extends Node3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func play_effect():
	$Sparks.emitting = true
	$Flash.emitting = true
	$Fire.emitting = true 
	$Smoke.emitting = true
