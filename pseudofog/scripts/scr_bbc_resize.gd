# UTILITY SCRIPT: BackBufferCopy auto-resizer
# 
# DESC.: Attatch this script to a BackBufferCopy to make it resize
# to the screen's resolution automatically. Useful for making
# Post-Processing effects work on multiple resolutions.

extends BackBufferCopy

func _ready():
	update_size()
	get_tree().root.connect("size_changed", self, "update_size")

func update_size():
	var window_size :Vector2 = get_viewport_rect().size / 2
	position = window_size
	scale = window_size / 100
