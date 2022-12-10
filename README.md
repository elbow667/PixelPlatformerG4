# PixelPlatformerG4
Heartbeast tutorial for Pixel Platformer but created in Godot 4.0 beta.<br>
See original tutorial here: <br>
	https://youtube.com/playlist?list=PL9FzW-m48fn16W1Sz5bhTd1ArQQv4f-Cm <br>
* Strings method empty() has been changed to is_empty() <br>
* For get_tree() change_scene() has changed to change_scene_to_file() <br>
* For the particles, under Process Material, Initial Velocity, velocity and  <br>
	Velocity Random have been replaced with Velocity Min and Velocity Max. <br>
* As of this writing, my player_spawn_location seems to be off by 10px causing <br>
	me to land inside a platform and get stuck.  I adjusted with <br>
	player_spawn_location = checkpoint_position + Vector2(0, -10) <br>
* Signals are different, instead of Events.connect("player_died", self, "_on_player_died") <br>
	you have Events.player_died.connect(_on_player_died) <br>
* Virtually nothing has changed with regards to Sound and Audio Busses <br>
* For PathFollow2d properties Offset and Unit Offset have been renamed to Progress <br> 
	and Progress Ratio <br>
* setget seems to have been removed and implimented differently in Godot 4.0, <br>
	as a result, the tool code for moving_spike_enemy.gd looks quite different. <br>
* commented out the @tool annotation due to editor stability issues (crashing). <br>
* find_node() has been removed in GDScript 2.0 and replaced with get_node(). <br>
* @export var moveData: PlayerMovmentData was sufficient to get autocompletion in 4.0 <br>
* On LadderCheck Raycast2D: make sure property "Hit from Inside" is selected. <br>
* velocity appears to be already defined and not needing to be passed into <br>
	move_and_slide().<br>
* Tilemaps implement Terrains instead of Autotile. <br>
* VisualServer appears to have changed to RenderingServer in Godot 4.0. <br>
