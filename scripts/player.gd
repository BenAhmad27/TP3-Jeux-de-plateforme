extends GenericCharacter
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var attacking = false

func _ready() -> void:
	anim_player = $AnimationPlayer
	sprite = $Sprite2D
	anim_player.play("Idle")
	
	# Quand l'animation finit, on revient à l'état normal
	anim_player.animation_finished.connect(_on_animation_finished)

func _physics_process(delta: float) -> void:
	if attacking:
		move_and_slide()
		return  # on bloque le reste du code

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		anim_player.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		anim_player.play("Idle")

	sprite.flip_h = direction < 0

	if Input.is_action_just_pressed("Attack"):
		attacking = true
		anim_player.play("Attack")

	move_and_slide()

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "Attack":
		attacking = false
