@tool

extends Path2D

enum ANIMATION_TYPE {
	LOOP, 
	BOUNCE
}
@onready var animationPlayer : = $AnimationPlayer

@export var animation_type : ANIMATION_TYPE:
#	get:
#		return animation_type
	set(value):
		animation_type = value
		if not is_inside_tree():
			await ready
		var ap = get_node("AnimationPlayer")
		if ap: play_updated_animation(ap)


@export var speed = 1:
#	get:
#		return speed
	set(value):
		speed = value
		if not is_inside_tree():
			await ready		
		var ap = get_node("AnimationPlayer")
		if ap: ap.playback_speed = speed

func _ready():
	play_updated_animation(animationPlayer)

func play_updated_animation(ap):
	match animation_type:
		ANIMATION_TYPE.LOOP: ap.play("MoveAlongPathLoop")
		ANIMATION_TYPE.BOUNCE: ap.play("MoveAlongPathBounce")
		
		
