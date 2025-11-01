extends Node3D

# Node refs
@onready var menu = $Menu
@onready var button_start = $Menu/Container/ButtonStart
@onready var level_label = $Menu/Container/LevelLabel
@onready var player = $Player
@onready var menu_music = $Sounds/MenuMusic
@onready var level_music = $Sounds/LevelMusic


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menu.visible = true
	update_level_label()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	level_music.stop()
	menu_music.play()


# Pause Menu
func _input(event: InputEvent):
	if event.is_action_pressed("ui_menu"):
		if menu.visible:
			get_tree().quit()
		else:
			update_level_label()
			menu.visible = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			button_start.text = "RESUME LEVEL"
			get_tree().paused = true 
			level_music.stop()
			menu_music.play()
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_start_pressed() -> void:
	if button_start.text == "NEW GAME":
		Global.new_game()
	menu.visible = false
	menu_music.stop()
	level_music.play()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	get_tree().paused = false


func _on_button_load_pressed() -> void:
	Global.load_game()
	menu.visible = false
	menu_music.stop()
	level_music.play()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	get_tree().paused = false
	player.reset_game_state()
	

func _on_button_exit_pressed() -> void:
	get_tree().quit()


# Show last saved lvel 
func update_level_label(): 
	Global.load_game() 
	level_label.text = "last saved level: %d" % Global.level
