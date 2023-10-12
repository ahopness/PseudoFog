tool
extends Viewport

func _ready():
	update_res()
	get_tree().root.connect("size_changed", self, "update_res")

func update_res():
	var renderpass_size :Vector2 = get_parent().get_viewport().size / 3
	size = renderpass_size

func _process(delta):
	var _current_cam = get_parent().get_viewport().get_camera()
	if _current_cam != null:
		$Camera.h_offset = _current_cam.h_offset
		$Camera.v_offset = _current_cam.v_offset
		$Camera.fov = _current_cam.fov
		$Camera.near = _current_cam.near
		$Camera.far = _current_cam.far
		$Camera.translation = _current_cam.translation
		$Camera.rotation_degrees = _current_cam.rotation_degrees
