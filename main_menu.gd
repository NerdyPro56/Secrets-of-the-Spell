extends Control
@onready var menu_button_89141: AudioStreamPlayer = $"MarginContainer/HBoxContainer/VBoxContainer/Start/Menu-button-89141"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	menu_button_89141.play()
	get_tree().change_scene_to_file("res://scenes/level1.tscn")
