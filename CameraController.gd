extends Spatial

var camera_speed = 5
onready var spring = $SpringArm

func _physics_process(delta):
	# Shout out to Redvillusion on Youtube!
	var forward = spring.transform.basis.z.normalized() * camera_speed
		
	if Input.is_action_pressed("key_left"):
		transform.origin += forward.cross(Vector3.UP) / 1.5
	if Input.is_action_pressed("key_right"):
		transform.origin += -forward.cross(Vector3.UP) / 1.5
		
	if Input.is_action_pressed("key_forward"):
		transform.origin += -Vector3(forward.x, translation.y, forward.z)
	if Input.is_action_pressed("key_backward"):
		transform.origin += Vector3(forward.x, translation.y, forward.z)
		
func _input(event):
	# Rotate camera left and right.
	if Input.is_action_just_pressed("camera_left"):
		spring.rotation_degrees.y -= 45
	if Input.is_action_just_pressed("camera_right"):
		spring.rotation_degrees.y += 45
