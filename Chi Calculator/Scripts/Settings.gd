extends Control

var BG_Color = Color( 0.294118, 0.294118, 0.294118, 1 );

func _ready():
	chi_load_settings();
	if OS.get_name() == "Android":
		$Settings_BTN_Save.visible = false;

var settings_path = str(OS.get_executable_path().get_base_dir()) + "/Settings/User_Settings.cfg";
var executable_path = OS.get_executable_path().get_base_dir();

func _on_Settings_BTN_Close_pressed():
	visible = false;

func _on_Settings_BTN_Save_pressed():
	chi_save_settings();

func chi_save_settings():
	var settings = ConfigFile.new();
	var dir = Directory.new();
	
	if dir.dir_exists(executable_path + "/Settings") == false:
		dir.open(executable_path);
		dir.make_dir("Settings");
		$Label2.text = settings_path;
		$Label3.text = executable_path;
		
	settings.set_value("Background", "BG_Color", BG_Color)
	settings.save(settings_path);

func chi_load_settings():
	var setti = ConfigFile.new();
	var diro = Directory.new();
	if diro.dir_exists(executable_path + "/Settings") == true:
		var sett = setti.load(settings_path);
		if sett == OK:
			if setti.get_value("Background", "BG_Color") != null:
				BG_Color = Color(setti.get_value("Background", "BG_Color"));

func _on_Settings_BTN_SysInfo_pressed():
	$Device.text = " " + OS.get_model_name(); # Название устройства
	$OS.text = " " + OS.get_name(); # Название операционной системы (Windows, Android, etc.)

func _on_Settings_SecretButton_pressed():
	if get_node("../../Calculator").chi_secret == 0:
		get_node("../../Calculator").chi_secret = 1;
		VisualServer.viewport_set_vflip(get_tree().get_root().get_viewport_rid(), true);
		OS.set_window_title("FU**!!!");
		yield(get_tree().create_timer(10.0), "timeout")
		VisualServer.viewport_set_vflip(get_tree().get_root().get_viewport_rid(), false);
		OS.set_window_title("Chi Calculator");
		get_node("../../Calculator").chi_secret = 0;


func _on_Settings_BTN_Color_Edit_pressed():
	$Color.visible = true;


func _on_Settings_BTN_Color_Edit_Close_pressed():
	$Color.visible = false;

func _on_Settings_BTN_Color_Edit_Set_pressed():
	VisualServer.set_default_clear_color($Color/ColorPicker.color);
	BG_Color = Color($Color/ColorPicker.color);




#$"/root".set_size_override(true, Vector2(data.Window_width, data.Window_height), Vector2(0,0));
#get_node("/root").get_viewport().set_size_override(true, Vector2(520, 540), Vector2(0,0));
#self.set_size(Vector2(620, 540));
#ProjectSettings.set_setting("display/window/size/width", data.Window_width);
#get_viewport().set_size_override(true, Vector2(data.Window_width, data.Window_height), Vector2(0,0));
#get_viewport().set_size_override_stretch(true);
#VisualServer.viewport_set_size(get_tree().get_root().get_viewport_rid(), 500, 500);
#VisualServer.viewport_set_msaa(get_tree().get_root().get_viewport_rid(),VisualServer.VIEWPORT_MSAA_DISABLED);
#$"/root".size = Vector2(data.Window_width, data.Window_height);
#$"/root".set_size_override(true, Vector2(data.Window_width, data.Window_height), Vector2(0,0))
