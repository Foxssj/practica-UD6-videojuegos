extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -450.0
var jump_count = 0
var max_jumps = 2
var attack = false
var score = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animSprite = $AnimatedChar


func recolect_coins(value):
	score += value


func _ready():
	animSprite.play("Idle")
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if jump_count == max_jumps and is_on_floor():
		jump_count = 0

	# Handle jump.
	if Input.is_action_just_pressed("up") or Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			jump_count = 0
		if jump_count < max_jumps:
			velocity.y = JUMP_VELOCITY
			$JumpSound.play()
			jump_count += 1
		

	if is_on_floor() and velocity.x == 0:
		animSprite.play("Idle")
	elif velocity.x > 0 or velocity.x < 0:
		animSprite.play("Run")
	else:
		animSprite.play("AirTime")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if !attack:
		if direction:
			velocity.x = direction * SPEED
			animSprite.flip_h = velocity.x > 0
			if is_on_floor():
				animSprite.play("Run")
			else:
				animSprite.play("Jump")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_pressed("attack") and is_on_floor():
		animSprite.play("Attack")
		await(animSprite.animation_finished)
		attack = true
		
	if Input.is_action_pressed("down") and Input.is_action_pressed("special_attack") and is_on_floor():
		animSprite.play("Kamehameha")
		await(animSprite.animation_finished)
		attack = true

		

	

	move_and_slide()



