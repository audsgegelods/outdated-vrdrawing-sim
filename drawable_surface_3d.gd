class_name DrawableSurface3D extends Node3D

@export var paint_color : Color = Color.RED
@export var img_size := Vector2i(128, 170)
@export var brush_size := 1.5

@onready var pxl_size = $Sprite3D.pixel_size

var img : Image
var topLeftCorner: Vector3
var bottomRightCorner: Vector3

func _ready() -> void:
	img = Image.create_empty(img_size.x, img_size.y, false, Image.FORMAT_RGBA8)
	img.fill(Color.WHITE)
	$Sprite3D.texture = ImageTexture.create_from_image(img)
	
	var collider_origin = self.global_position
	
	set_sprite_collider(img_size, pxl_size)
	set_reference_corners(collider_origin, img_size, pxl_size)
	print($StaticBody3D.scale)
	print(topLeftCorner)
	print(bottomRightCorner)

func _process(delta) -> void:
	pass

func set_sprite_collider(img_size: Vector2i, pxl_size: float):
	$StaticBody3D.scale = Vector3(img_size.x * pxl_size, 0.3, img_size.y * pxl_size)

func set_reference_corners(origin: Vector3, img_size: Vector2i, pxl_size: float):	# Plane reference corners in world-space
	topLeftCorner = origin + Vector3(-img_size.x * pxl_size / 2.0, origin.y, -img_size.y * pxl_size / 2.0)
	bottomRightCorner = origin + Vector3(img_size.x * pxl_size / 2.0, origin.y, img_size.y * pxl_size / 2.0)

func _paint_tex(pos) -> void:	#TODO: add global via param
	img.fill_rect(Rect2i(pos, Vector2i(1, 1)).grow(brush_size), paint_color)

func flatten_pencil_contact_vector(pos: Vector3):
	var flattened_vec = Vector2(pos.x, pos.z)
	return flattened_vec

func convert_img_pos(pos: Vector3):
	var local_pos = to_local(pos)
	var img_pos = Vector3.ZERO
	img_pos.x = (local_pos.x - topLeftCorner.x) * img_size.x / (bottomRightCorner.x - topLeftCorner.x)
	img_pos.z = (local_pos.z - topLeftCorner.z) * img_size.y / (bottomRightCorner.z - topLeftCorner.z)
	#img_pos = local_pos - Vector3($Sprite3D.offset.x, $Sprite3D.offset.y, 0) + $StaticBody3D/CollisionShape3D.shape.size/2.0
	return img_pos

func _on_pen_contact_drawable_surface(pos: Vector3):
	var local_pos
	local_pos = convert_img_pos(pos)
	#print(local_pos)
	var flattened_local_pos = flatten_pencil_contact_vector(local_pos)
	print(flattened_local_pos)
	
	_paint_tex(flattened_local_pos)
	$Sprite3D.texture.update(img)
	
	#print(flattened_local_pos)
