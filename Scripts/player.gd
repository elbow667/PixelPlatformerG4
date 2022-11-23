extends CharacterBody2D
class_name Player

enum {MOVE, CLIMB}
var state := MOVE

#var velocity = Vector2.ZERO
# velocity already defined in CharacterBody2D
#@export var SPEED : float = 100.0

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var ladderCheck : RayCast2D = $LadderCheck

@export var moveData : Resource


func _ready():
	animated_sprite.frames = load("res://Scenes/player_pink_skin.tres")

func _physics_process(_delta):

	var direction = Vector2.ZERO
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	
	match state:
		MOVE: move_state(direction)
		CLIMB: climb_state(direction)
	

	

func move_state(direction):
	if is_on_ladder() and Input.is_action_pressed("ui_up"):
		state = CLIMB
	apply_gravity()
	if direction: # if not zero
		apply_acceleration(direction.x)
		animated_sprite.animation = "Run"
		animated_sprite.flip_h = direction.x > 0
#		if (velocity.x > 0):
#			animated_sprite.flip_h = true
#		elif(velocity.x < 0):
#			animated_sprite.flip_h = false
	else:
		apply_friction()
		animated_sprite.animation = "Idle"

	if is_on_floor():

		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = moveData.JUMP_FORCE
	else:
		animated_sprite.animation = "Jump"
		if Input.is_action_just_released("ui_accept") and velocity.y < moveData.JUMP_RELEASE_FORCE:
			velocity.y = moveData.JUMP_RELEASE_FORCE
		if velocity.y > 0:
			velocity.y += moveData.ADDITIONAL_FALL_GRAVITY


	var was_in_air = not is_on_floor()
	var _velocity = move_and_slide() #no need to pass velocity into move_and_slide()
	var just_landed = is_on_floor() and was_in_air
	if just_landed:
		animated_sprite.animation = "Run"
		animated_sprite.frame = 1

func climb_state(direction):
	if not is_on_ladder():
		state = MOVE
	if direction.length() != 0:
		animated_sprite.animation = "Run"
	else: animated_sprite.animation = "Idle"	
	velocity = direction * 50
	var _velocity = move_and_slide()
		

func is_on_ladder():
	if not ladderCheck.is_colliding(): return false
	var collider = ladderCheck.get_collider()
	if not collider is Ladder: return false
	return true
		
func apply_gravity():
	velocity.y += moveData.GRAVITY
	velocity.y = min(velocity.y, 300)

func apply_friction():
	velocity.x = move_toward(velocity.x, 0, moveData.FRICTION)
	
func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, moveData.MAX_SPEED * amount, moveData.ACCELLERATION)
	
	
