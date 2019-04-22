extends Spatial

func _ready():
	$"Enemy Body/Health".connect("on_zero_hp",self,"_on_zero_hp")
	pass

func _on_zero_hp():
	get_parent().get_node("Camera").shake()
	queue_free()
	pass