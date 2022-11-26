#@tool
# tool stuff doesn't seem to be working in Godot 4.0
# setget is implemented differently in Godot 4.0, since its not working
# and none of the examples I have seeked out have worked for this so I have 
# no idea if i'm doing it correctly so I have commented it out.

extends Path2D

enum ANIMATION_TYPE {
	LOOP, 
	BOUNCE
}

@export var animation_type : ANIMATION_TYPE #:
#	get:
#		return animation_type
#	set(value):
#		set_animation_type(value)
#
#func set_animation_type(value):
#	animation_type = value
#	play_updated_animation(animationPlayer)
#@export var speed : int = 1:
#	get:
#		return speed
#	set(value):
#		var ap = find_child("AnimationPlayer")
#		if ap: ap.playback_speed = speed
		

@onready var animationPlayer : AnimationPlayer = $AnimationPlayer


func _ready():
	play_updated_animation(animationPlayer)

func play_updated_animation(animationPlayer):
	match animation_type:
		ANIMATION_TYPE.LOOP: animationPlayer.play("MoveAlongPathLoop")
		ANIMATION_TYPE.BOUNCE: animationPlayer.play("MoveAlongPathBounce")
		
		
