extends Control

#var interpreter_path
#var script_path
var root_window : Window

var clicks := 0
var cps_count := 0

@onready var clicktext = $LayoutCont/TextCont/Clicks
@onready var cpstext = $LayoutCont/TextCont/Cps

func _ready():
	root_window = get_tree().get_root()
	root_window.set_flag(Window.FLAG_BORDERLESS, true)
	
	#if OS.has_feature("template"): # if exported
		#var res_dir = OS.get_executable_path().get_base_dir()
		#var interpreter_path = res_dir.path_join("python/venv/Scripts/python.exe")
		#var script_path = res_dir.path_join("python/cps.py")
	#else:
		#var interpreter_path = ProjectSettings.globalize_path("res://python/venv/Scripts/python.exe")
		#var script_path = ProjectSettings.globalize_path("res://python/cps.py")

	pass
	
#func run_python():
	#OS.create_process(interpreter_path, [script_path])
func _physics_process(_delta):
	if GlobalInput.is_action_just_pressed("click"):
		clicks += 1
		clicktext.set_text("%d clicks" % clicks)
		#var click_cps_timer = Timer.new()
		#click_cps_timer.timeout.connect(_on_cps_timer_timeout.bind(click_cps_timer))
		#click_cps_timer.start(1.0)
		#click_cps_timer.set_autostart(true)
		cps_count += 1
		get_tree().create_timer(1.0, true, true).timeout.connect(func(): cps_count -= 1)
		
		
	cpstext.set_text("%d cps" % cps_count)
	
	if GlobalInput.is_action_pressed("click"):
		clicktext.get_label_settings().set_font_color(Color("ff0000"))
	else:
		clicktext.get_label_settings().set_font_color(Color("ffffff"))

func _input(_event):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		clicks = 0
		clicktext.set_text("%d clicks" % clicks)
	#elif Input.is_action_just_pressed("minimize"):
		#root_window.set_mode(Window.MODE_MINIMIZED)
		
	if Input.is_action_pressed("drag"):
		root_window.set_position(DisplayServer.mouse_get_position() - Vector2i(self.size / 2))
		
#func _on_cps_timer_timeout(timer_reference : Timer):
	#timer_reference.queue_free()
