class_name PaddleController extends Component2D

var v_axis:float = 0 :
	set(value):
		if abs(value) > abs(v_axis):
			v_axis_down = value
			await get_tree().process_frame
			v_axis_down = 0
		elif abs(value) < abs(v_axis):
			v_axis_up = v_axis
			await get_tree().process_frame
			v_axis_up = 0

		v_axis = value

var v_axis_down:float = 0
var v_axis_up:float = 0

var sprint_pressed:bool = false
var sprint_down:bool = false
var sprint_up:bool = false

var ability_pressed:bool = false
var ability_down:bool = false
var ability_up:bool = false
