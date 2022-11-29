extends Node

const HURT = preload("res://Sounds/hurt.wav")
const JUMP = preload("res://Sounds/jump.wav")

# sound_player.tscn needs to be an autoload for this to work

@onready var audioPlayers: = $AudioPlayers

func play_sound(sound):
	for audioStreamPlayer in audioPlayers.get_children():
		if not audioStreamPlayer.playing:
			audioStreamPlayer.stream = sound
			audioStreamPlayer.play()
			break


