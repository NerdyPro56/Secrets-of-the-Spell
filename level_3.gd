extends Node2D
@onready var textbox: CanvasLayer = $Textbox
@onready var player: CharacterBody2D = $player
@onready var golem: CharacterBody2D = $Golem
@onready var timer: Timer = $Timer
@onready var golem_2: CharacterBody2D = $Golem2
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var golem_3: CharacterBody2D = $Golem3
@onready var golem_4: CharacterBody2D = $Golem4
@onready var golem_5: CharacterBody2D = $Golem5
@onready var timer_2: Timer = $Timer2
@onready var wizard: Sprite2D = $wizard
@onready var dark_tension_248083: AudioStreamPlayer = $"Dark-tension-248083"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer_3: Timer = $Timer3

var done = false
var done2 = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.cutscene = true
	golem.cut = true
	golem_2.cut = true
	golem_3.cut = true
	golem_4.cut = true
	golem_5.cut = true
	textbox.queue_text("hey there!     ")
	textbox.queue_text("You're kinda stupid for walking into that teleporter trap...      ")
	textbox.queue_text("That's coming from a brainless golem by the way       ")
	textbox.queue_text("Welp...    ") 
	textbox.queue_text("Get ready to run!    ") 
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	player.cutscene = false
	golem.cut = false
	audio_stream_player.play()
	


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body == player:
		textbox.queue_text("hello there      ")
		golem_2.cut = false


func _on_area_2d_2_body_entered(body: CharacterBody2D) -> void:
	if body == player:
		textbox.queue_text("come back here!      ")
		golem_3.cut = false


func _on_area_2d_3_body_entered(body: Node2D) -> void:
	if body == player and !done:
		done = true
		audio_stream_player.stop()
		player.cutscene = true
		player.sword = false
		textbox.queue_text("you thought you could escape that easily?         ")
		textbox.queue_text("Well Think Again!       ")
		textbox.queue_text("Ill be taking your sword. good luck youll need it (:<            ")
		timer_2.start()



func _on_timer_2_timeout() -> void:
	golem_4.cut = false
	golem_5.cut = false
	player.cutscene = false
	wizard.visible = false
	dark_tension_248083.play()


func body_entered(body: CharacterBody2D) -> void:
	if body == player and !done2:
		done2 = true
		player.cutscene = true
		player.spells = true
		animation_player.play("open")
		timer_3.start()
		


func _on_timer_3_timeout() -> void:
	player.cutscene = false
	textbox.queue_text("Press R to use Spells                ")


func _on_area_2d_4_body_entered(body: CharacterBody2D) -> void:
	if body == player:
		get_tree().change_scene_to_file("res://scenes/level_4.tscn")
