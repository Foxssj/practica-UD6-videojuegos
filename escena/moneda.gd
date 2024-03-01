extends Node2D


var valor = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.has_method("recolect_coins") and body.name == "Player":
		body.recolect_coins(valor)
		$Sprite2D/CoinSound.playing = true
		await(get_tree().create_timer(0.180)).timeout
		var label_score:Label = get_node("/root/Level_1/Player/Player/Camera2D/Hud/VBoxContainer/Background/HBox/Margin2/Score")
		label_score.text = "Score: " + str(body.score)
		queue_free()
