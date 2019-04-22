extends Camera

export var duration = 0.2
export var magnitude = 0.3

var start_h
var start_v
var shaking = false

func _ready():
	start_h = h_offset
	start_v = v_offset
	
	$Timer.one_shot = true
	$Timer.connect("timeout",self,"_on_finished_shaking")
	pass

func shake(magnitude=self.magnitude,duration=self.duration,shake_h=true,shake_v=true):
	if shaking :
		return
	
	$Timer.start(duration)
	shaking = true
	
	while shaking:
		var d = deg2rad(rand_range(0,360))
		if shake_h:
			var h = cos(d)*magnitude
			h_offset = h
		if shake_v:
			var v = sin(d)*magnitude
			v_offset = v
		
		yield(get_tree(),"idle_frame")
	
	h_offset = start_h
	v_offset = start_v
	pass

func _on_finished_shaking():
	shaking = false
	pass