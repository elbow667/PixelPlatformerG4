extends CharacterBody2D
class_name Player

enum {MOVE, CLIMB}
var state = MOVE
var double_jump = 1
var buffered_jump = false
var coyote_jump = false


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ladderCheck: RayCast2D = $LadderCheck
@onready var jumpBufferTimer: Timer = $JumpBufferTimer
@onready var coyoteJumpTimer: Timer = $CoyoteJumpTimer
@onready var remoteTransform2D: = $RemoteTransform2D

@export var moveData: PlayerMovmentData


func _ready():
	animated_sprite.frames = load("res://Scenes/player_pink_skin.tres")

func _physics_process(delta):

	var direction = Vector2.ZERO
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	
	match state:
		MOVE: move_state(direction, delta)
		CLIMB: climb_state(direction)

func move_state(direction, delta):
	if is_on_ladder() and Input.is_action_just_pressed("ui_up"):
		state = CLIMB
	apply_gravity(delta)
	
	
	if  horizontal_move(direction): # if not zero
		apply_acceleration(direction.x, delta)
		animated_sprite.animation = "Run"
		animated_sprite.flip_h = direction.x > 0
	else:
		apply_friction(delta)
		animated_sprite.animation = "Idle"
		
	if is_on_floor():
		reset_double_jump()
	else:
		animated_sprite.animation = "Jump"
		
	if can_jump():
		input_jump()
	else:
		input_jump_release()
		input_double_jump()
		buffer_jump()
		fast_fall(delta)


	var was_in_air = not is_on_floor()
	var was_on_floor = is_on_floor()
		
	var _velocity = move_and_slide() #no need to pass velocity into move_and_slide()
	var just_landed = is_on_floor() and was_in_air
	if just_landed:
		animated_sprite.animation = "Run"
		animated_sprite.frame = 1
	var just_left_ground = not is_on_floor() and was_on_floor
	if just_left_ground and velocity.y >= 0:
		coyote_jump = true
		coyoteJumpTimer.start()

func player_die():
	SoundPlayer.play_sound(SoundPlayer.HURT)
	queue_free()
	Events.player_died.emit()


func connect_camera(camera):
	var camera_path = camera.get_path()
	remoteTransform2D.remote_path = camera_path

func can_jump():
	return is_on_floor() or coyote_jump

func input_jump_release():
	
	if Input.is_action_just_released("ui_accept") and velocity.y < moveData.JUMP_RELEASE_FORCE:
		velocity.y = moveData.JUMP_RELEASE_FORCE

func input_double_jump():
	if Input.is_action_just_pressed("ui_accept") and double_jump > 0:
		SoundPlayer.play_sound(SoundPlayer.JUMP)
		velocity.y = moveData.JUMP_FORCE
		double_jump -= 1

func buffer_jump():
	if Input.is_action_just_pressed("ui_accept"):
		buffered_jump = true
		jumpBufferTimer.start()

func fast_fall(delta):
	if velocity.y > 0:
		velocity.y += moveData.ADDITIONAL_FALL_GRAVITY * delta

func horizontal_move(direction):
	return direction.x != 0	
	
func reset_double_jump():
	double_jump = moveData.DOUBLE_JUMP_COUNT
	
func input_jump():
	if Input.is_action_just_pressed("ui_accept") or buffered_jump:
		SoundPlayer.play_sound(SoundPlayer.JUMP)
		velocity.y = moveData.JUMP_FORCE
		buffered_jump = false

func climb_state(direction):
	if not is_on_ladder():
		state = MOVE
	if direction.length() != 0:
		animated_sprite.animation = "Run"
	else: animated_sprite.animation = "Idle"	
	velocity = direction * moveData.CLIMB_SPEED
	var _velocity = move_and_slide()

func is_on_ladder():
	if not ladderCheck.is_colliding(): return false
	var collider = ladderCheck.get_collider()
	if not collider is Ladder: return false
	return true

func apply_gravity(delta):
	velocity.y += moveData.GRAVITY * delta
	velocity.y = min(velocity.y, 300)

func apply_friction(delta):
	velocity.x = move_toward(velocity.x, 0, moveData.FRICTION * delta)

func apply_acceleration(amount, delta):
	velocity.x = move_toward(velocity.x, moveData.MAX_SPEED * amount, moveData.ACCELLERATION * delta)


func _on_jump_buffer_timer_timeout():
	buffered_jump = false

func _on_coyote_jump_timer_timeout():
	coyote_jump = false
