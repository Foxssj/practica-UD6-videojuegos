extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_body_entered(body):
	if body.name == "Player":
		if body.score >= 17:
			$LevelComplete.play()
			get_tree().change_scene_to_file("res://escena/main.tscn")
		
