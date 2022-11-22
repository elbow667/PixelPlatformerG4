extends CharacterBody2D
class_name Player

#var velocity = Vector2.ZERO
# velocity already defined in CharacterBody2D
#@export var SPEED : float = 100.0

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

@export var moveData : Resource

func _ready():
	animated_sprite.frames = load("res://Scenes/player_pink_skin.tres")

func _physics_process(_delta):
	apply_gravity()
	
	var direction = Vector2.ZERO
	
	direction = Input.get_axis("ui_left", "ui_right")
	if direction: # if not zero
		apply_acceleration(direction)
		animated_sprite.animation = "Run"
		animated_sprite.flip_h = velocity.x > 0
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
		
func apply_gravity():
	velocity.y += moveData.GRAVITY
	velocity.y = min(velocity.y, 300)

func apply_friction():
	velocity.x = move_toward(velocity.x, 0, moveData.FRICTION)
	
func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, moveData.MAX_SPEED * amount, moveData.ACCELLERATION)
	
	
