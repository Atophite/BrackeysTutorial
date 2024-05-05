extends Node
@onready var score_label = %ScoreLabel
@onready var hud = %HUD
@onready var time_label = %TimeLabel

var score = 0
var fast_time = 0
var current_time = 0

func add_point():
	score += 1
	hud.update_score(score)
	if score == 7:
		score_label.text = "You collected " + str(score) + " coins."
	

func map_finished():
	if score == 7:
		current_time = hud.stop_timer()
		if current_time < fast_time:
			fast_time = current_time
			time_label.text = "Your fastest time is " + format_time(fast_time)
			save_game()

func save_game():
	var data = {
		"time": fast_time
	}
	var file = FileAccess.open("user://game-data.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()

func load_game():
	if FileAccess.file_exists("user://game-data.json"):
		var file = FileAccess.open("user://game-data.json", FileAccess.READ)
		if file != null:
			var content = file.get_as_text()
			file.close()
			var json = JSON.new()
			var error = json.parse(content)
			if error == OK:
				print(json.data)
				fast_time = json.data["time"]
				time_label.text = "Your fastest time is " + format_time(fast_time)
		else:
			print("Failed to open file for reading")
	else:
		print("No save file found")

func format_time(total_milliseconds):
	var total_seconds = int(total_milliseconds / 1000)
	var minutes = int(total_seconds / 60)
	var seconds = int(total_seconds % 60)
	var milliseconds_remainder = int(total_milliseconds) % 1000
	
	var formatted_time = ("%02d" % minutes) + ":" + ("%02d" % seconds) + ":" + ("%02d" % milliseconds_remainder)
	return formatted_time

func _on_ready():
	load_game()
