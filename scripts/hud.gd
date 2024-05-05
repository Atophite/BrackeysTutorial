extends CanvasLayer
@onready var ui_score_label = $UIScoreLabel
@onready var ui_timer_label = $UITimerLabel

var timer_running = true
var elapsed_time = 0

func update_score(score):
	ui_score_label.text = "Coins: " + str(score)
	
func _process(delta):
	# Update the displayed time
	if timer_running:
		elapsed_time += delta
		update_time_label()

func update_time_label():
	# Format the elapsed time and update the label
	var minutes = int(elapsed_time / 60)
	var seconds = int(elapsed_time) % 60
	var milliseconds = int((elapsed_time - int(elapsed_time)) * 1000)
	var formatted_milliseconds = ("%03d" % milliseconds).substr(0, 2)
	ui_timer_label.text = str(minutes) + ":" + str(seconds) + ":" + str(formatted_milliseconds)
	
func stop_timer():
	timer_running = false
	var total_milliseconds = (int(elapsed_time) * 1000) + int((elapsed_time - int(elapsed_time)) * 1000)
	return total_milliseconds
