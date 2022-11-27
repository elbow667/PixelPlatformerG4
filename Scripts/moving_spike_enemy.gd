@tool

extends Path2D

enum ANIMATION_TYPE {
	LOOP, 
	BOUNCE
}

@export var animation_type : ANIMATION_TYPE:
	get:
		return animation_type
	set(value):
		animation_type = value
		var ap = get_node("AnimationPlayer")
		if ap: play_updated_animation(ap)

@export var speed = 1:
	get:
		return speed
	set(value):
		speed = value
		var ap = get_node("AnimationPlayer")
		if ap: ap.playback_speed = speed

@onready var animationPlayer : AnimationPlayer = $AnimationPlayer


func _ready():
	play_updated_animation(animationPlayer)

func play_updated_animation(animationPlayer):
	match animation_type:
		ANIMATION_TYPE.LOOP: animationPlayer.play("MoveAlongPathLoop")
		ANIMATION_TYPE.BOUNCE: animationPlayer.play("MoveAlongPathBounce")
		
		
