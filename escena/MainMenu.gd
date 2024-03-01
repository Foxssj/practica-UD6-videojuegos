extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$main_menu_music.play()

var background_speed = 50
var background_position = 0

func _process(delta):
	# Mueve el fondo gradualmente
	background_position += background_speed * delta
	if background_position < 1000:
		$Camera2D/ParallaxBackground.set_offset(Vector2(background_position, 0))
	else:
		background_position = 0



func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://escena/level_1.tscn")


func _on_exit_button_pressed():
	get_tree().quit()

