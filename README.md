# PixelPlatformerG4
Heartbeast tutorial for Pixel Platformer but created in Godot 4.0 beta.<br>
* For PathFollow2d properties Offset and Unit Offset have been renamed to Progress <br> 
	and Progress Ratio <br>
* setget seems to have been removed and implimented differently in Godot 4.0, <br>
	as a result, the tool code for moving_spike_enemy.gd looks quite different. <br>
* @export var moveData: PlayerMovmentData was sufficient to get autocompletion in 4.0 <br>
* On LadderCheck Raycast2D: make sure property "Hit from Inside" is selected. <br>
* velocity appears to be already defined and not needing to be passed into <br>
	move_and_slide().<br>
* Tilemaps implement Terrains instead of Autotile. <br>
* VisualServer appears to have changed to RenderingServer in Godot 4.0. <br>
