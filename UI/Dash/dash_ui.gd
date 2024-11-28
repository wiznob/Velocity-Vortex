extends Control
signal final_time
var total_time = 0
var coins = 0
var current_time
func _ready():
	$Timer.wait_time = 0.01
	$Timer.start()


func _on_timer_timeout():
	total_time += 1
	print(total_time)
	var m = int(total_time / 6000.0) 
	var s = int((total_time % 6000) / 100.0)
	var ms = total_time % 100  
	current_time = '%02d:%02d:%02d' % [m, s, ms]# used by leaderboard
	$timerLabel.text = '%02d:%02d:%02d' % [m, s, ms]
