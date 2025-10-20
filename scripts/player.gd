extends GenericCharacter
class_name Player

func _ready() -> void:
	anim_player = $AnimationPlayer
	sprite = $Sprite2D
	anim_player.play("Idle")

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		anim_player.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		anim_player.play("Idle")
	sprite.flip_h = direction < 0
	
	if Input.is_action_just_pressed("Attack") :
		anim_player.play("Attack")

	

	move_and_slide()
