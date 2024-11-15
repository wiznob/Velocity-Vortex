extends Control

var total_time = 0

func _ready():
	$Timer.wait_time = 0.01
	$Timer.start()


func _on_timer_timeout():
	total_time += 1
	var m = int(total_time / 6000.0) 
	var s = int((total_time % 6000) / 100.0)
	var ms = total_time % 100  
	$timerLabel.text = '%02d:%02d:%02d' % [m, s, ms]
