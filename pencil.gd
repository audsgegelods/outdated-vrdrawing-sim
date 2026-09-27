class_name pencil extends Node3D

signal contact_drawable_surface(pos: Vector3)
@export var speed = 2
@onready var raycast : RayCast3D = $RayCast3D

#func _ready() -> void:
	#pass

func _physics_process(delta) -> void:
	#var dir = Vector3.ZERO
	#
	#if Input.is_action_pressed("forward"):
		#dir.z -= 1
	#if Input.is_action_pressed("backward"):
		#dir.z += 1
	#if Input.is_action_pressed("left"):
		#dir.x -= 1
	#if Input.is_action_pressed("right"):
		#dir.x += 1
	#
	#if dir != Vector3.ZERO:
		#dir = dir.normalized()
		#
	#var target_vel = Vector3.ZERO
	#target_vel.x = dir.x * speed
	#target_vel.z = dir.z * speed
	#
	#$CharacterBody3D.velocity = target_vel
	#$CharacterBody3D.move_and_slide()
	
	if raycast.is_colliding():
		contact_drawable_surface.emit(raycast.get_collision_point())
		print(raycast.get_collision_point())
	else:
		pass

#func handle_movement() -> Vector3:
	#var dir = Vector3.ZERO
	#
	#if Input.is_action_pressed("forward"):
		#dir.z -= 1
	#if Input.is_action_pressed("backward"):
		#dir.z += 1
	#if Input.is_action_pressed("left"):
		#dir.x -= 1
	#if Input.is_action_pressed("right"):
		#dir.x += 1
	#
	#if dir != Vector3.ZERO:
		#dir = dir.normalized()
	#return dir
