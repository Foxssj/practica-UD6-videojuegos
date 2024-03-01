extends Control

var is_paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_pause_pressed():
	if InputEventMouse:
			
		is_paused = true
		get_tree().paused = not get_tree().paused
		$PauseMenu.visible = not $PauseMenu.visible


func _on_resume_button_pressed():
	$PauseMenu.visible = false
	get_tree().paused = not get_tree().paused


func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://escena/main.tscn")
