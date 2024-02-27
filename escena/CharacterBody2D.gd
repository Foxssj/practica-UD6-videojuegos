extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -450.0
var jump_count = 0
var max_jumps = 2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animSprite = $AnimatedSprite/Character


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
	if direction:
		velocity.x = direction * SPEED
		animSprite.flip_h = velocity.x > 0
		if is_on_floor():
			animSprite.play("Run")
		else:
			animSprite.play("Jump")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_just_pressed("attack"):
		animSprite.play("Attack")
		
	if Input.is_action_pressed("down") and Input.is_action_pressed("attack"):
		animSprite.play("Kamehameha")
		await(get_tree().create_timer(0.1)).timeout
	


	move_and_slide()

