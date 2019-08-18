extends KinematicBody2D

const LASER = preload("res://Laser.tscn")
const PLAYER_SPEED: int = 200
const RELOAD_TIME: float = 0.5
var reloading: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("fire"):
		fire()
	reloading -= delta
		
func fire():
	if readyToFire():
		var left_laser = LASER.instance()
		var right_laser = LASER.instance()
		
		left_laser.global_position = global_position
		left_laser.position.x -= 34
		left_laser.position.y -= 27
		
		right_laser.global_position = global_position
		right_laser.position.x += 35
		right_laser.position.y -= 27
		
		get_parent().add_child(left_laser)
		get_parent().add_child(right_laser)
		reloading = RELOAD_TIME
	
func readyToFire():
	return (reloading <= 0.0)

func _physics_process(delta):
	var move_vec = Vector2()
	if Input.is_action_pressed("move_up"):
		move_vec.y = -1
	if Input.is_action_pressed("move_down"):
		move_vec.y = 1
	if Input.is_action_pressed("move_left"):
		move_vec.x = -1
	if Input.is_action_pressed("move_right"):
		move_vec.x = 1
	move_vec = move_vec.normalized()
	move_and_collide(move_vec * PLAYER_SPEED * delta) 	