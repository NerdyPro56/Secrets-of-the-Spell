extends Node2D

@export var locked: bool = true  # Whether the door starts locked
@export var key_needed: String = "key"  # The type of key needed to unlock the door

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $Area2D/CollisionShape2D
@onready var textbox: CanvasLayer = $Textbox

var is_open: bool = false  # Tracks whether the door is open

func _ready():
	update_door_state()

func toggle_door(player):
	if locked:
		if player.has_key(key_needed):  # Check if the player has the required key
			locked = false
			player.use_key(key_needed)  # Use the key to unlock the door
		else:
			textbox.queue_text("Door is locked! You need a key. (find it or kill glowing bat)")
			return
	is_open = !is_open
	update_door_state()

func update_door_state():
	if is_open:
		queue_free()
func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body.name == "player":  # Adjust the name check as needed
		toggle_door(body)
