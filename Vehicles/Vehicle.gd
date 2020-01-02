extends RigidBody2D

export var grip = 1.0
export var steering_speed = 0.5
export var steering_speed_decay = 0.1
# true: steering wheels return to their forward position
# false: steering wheels remain at their current angle
export var center_steering = true
export var air_resistance = 0.1
onready var right = global_transform.x.normalized()
onready var wheel_group = str(get_instance_id()) + "-wheels"  # unique name for the wheel group


func _ready():
	# add wheels to group with unique name
	var wheels = get_node("Wheels").get_children()
	for wheel in wheels:
		wheel.add_to_group(wheel_group)

	# tire setup
	get_tree().set_group(wheel_group, "vehicle", self)
	get_tree().set_group(wheel_group, "grip", grip)
	get_tree().set_group(wheel_group, "steering_speed", steering_speed)
	get_tree().set_group(wheel_group, "center_steering", center_steering)


func _process(delta):
	right = global_transform.x.normalized()


func _physics_process(delta):
	# acceleration input
	var drive_input = 0
	if Input.is_action_pressed("accelerate"):
		drive_input = 1
	if Input.is_action_pressed("decelerate"):
		drive_input = -1
	get_tree().call_group(wheel_group, "drive", drive_input)
	
	# steering input
	var steering_input = 0.0
	if Input.is_action_pressed("steer_right"):
		steering_input += 1.0
	if Input.is_action_pressed("steer_left"):
		steering_input -= 1.0
	steering_input /= 0.01 * steering_speed_decay * linear_velocity.length() + 1.0
	get_tree().call_group(wheel_group, "steer", steering_input)
	
	# lateral tire forces
	get_tree().call_group(wheel_group, "apply_lateral_forces")
	
	# "air resistance"
	var vel = 0.005 * linear_velocity
	apply_central_impulse(-air_resistance * vel)
	# air resistance *should* scale quadratically with velssssocity but whatever
#	var velSquared = vel.length_squared() * vel.normalized()
#	apply_central_impulse(-air_resistance * velSquared)


