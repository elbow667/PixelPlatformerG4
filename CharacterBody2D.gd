extends CharacterBody2D

@export var JUMP_FORCE : int = -130
@export var JUMP_RELEASE_FORCE: int = -70
@export var MAX_SPEED : int = 50
@export var FRICTION : int = 10
@export var ACCELLERATION : int = 10
@export var GRAVITY : int = 4
@export var ADDITIONAL_FALL_GRAVITY : int = 4
@onready var animated_sprite := $AnimatedSprite2D

var direction = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not is_on_floor():
		animated_sprite.animation = "Run"
		print("Jump")
		#apply_gravity()
