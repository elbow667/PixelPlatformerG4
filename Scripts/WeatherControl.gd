extends StaticBody2D


var current_weather: String = "rain" # none, rain, ???
@onready var rain: = $Rain
@onready var rain_color: = $RainColor





# Called when the node enters the scene tree for the first time.
func _ready():
	if current_weather == "none":
		rain.visible = false
		rain_color.visible = false
	if current_weather == "rain":
		rain.visible = true
		rain_color.visible = true


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
