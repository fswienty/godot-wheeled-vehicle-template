extends Sprite

onready var player: RigidBody2D # set by Player.gd, until then just some temporary rigidbody so that the script doesn't shit itself

# steering variables
export var is_steering = false  # wether a wheel responds to steering input
export var max_angle = 0.0  # maximum anngle the wheel can steer to
var steering_speed = 0.0  # how fast the wheel steers, set by Player.gd
var center_steering = true  # see explanation in Player.gd

export var power = 0.0  # how much a wheel responds to drive input
var grip = 0.0  # grip of the tire, set by Player.gd

onready var forward = -global_transform.y.normalized()
onready var right = global_transform.x.normalized()
onready var player_to_wheel = Vector2(0, 0)

onready var last_position = global_position
onready var linear_velocity = global_position - last_position


func _process(delta):
	# update direction unit vectors and position vector relative to body
	forward = -(global_transform.y.normalized())
	right = global_transform.x.normalized()
	player_to_wheel = global_position - player.global_position


func _physics_process(delta):
	# get approximate velocity vector
	linear_velocity = global_position - last_position
	last_position = global_position


func steer(steering_input):
	if is_steering:
		var desired_angle = steering_input * max_angle
		if steering_input == 0 and not center_steering:
			desired_angle = rotation_degrees
		var new_angle = lerp(rotation_degrees, desired_angle, steering_speed)
		rotation_degrees = new_angle


func drive(drive_input):
	player.apply_impulse(player_to_wheel, drive_input * power * forward)


func apply_lateral_forces():
	var lateral_velocity = linear_velocity.dot(right)
	player.apply_impulse(player_to_wheel, -(grip * lateral_velocity * right))

