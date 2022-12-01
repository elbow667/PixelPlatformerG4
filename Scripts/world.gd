extends Node2D

const PlayerScene = preload("res://Scenes/player.tscn")

var player_spawn_location = Vector2.ZERO

@onready var camera: = $Camera2D
@onready var player: = $Player
@onready var timer: = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	RenderingServer.set_default_clear_color(Color.DARK_TURQUOISE)
	player.connect_camera(camera)
	player_spawn_location = player.global_position
	Events.player_died.connect(_on_player_died)
	Events.hit_checkpoint.connect(_on_hit_checkpoint)

func _on_player_died():
	timer.start(1.0)
	await timer.timeout
	var player = PlayerScene.instantiate()
	player.position = player_spawn_location
	add_child(player)
	player.connect_camera(camera)

func _on_hit_checkpoint(checkpoint_position):
	# somehow i'm off by 10px exactly on the y axis adjusting for now
	player_spawn_location = checkpoint_position + Vector2(0, -10)
	
