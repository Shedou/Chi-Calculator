extends Control

func _ready():
	if OS.get_name() == "Android":
		$Settings_BTN_Save.visible = false;

func _on_Settings_BTN_Close_pressed():
	visible = false;

func _on_Settings_BTN_Save_pressed():
	chi_save_settings();

func chi_save_settings():
	var settings = ConfigFile.new();
	var dir = Directory.new();
	
	if dir.dir_exists($"../".chi_executable_path + "/Settings") == false:
		dir.open($"../".chi_executable_path);
		dir.make_dir("Settings");
		settings.set_value("Background", "BG_Color", $"../".chi_user_BG_Color);
		settings.save($"../".chi_user_settings_path);
		$Label2.text = "Created folder:\n" + $"../".chi_executable_path + "Created file:\n" + $"../".chi_user_settings_path;
	else:
		settings.set_value("Background", "BG_Color", $"../".chi_user_BG_Color)
		settings.save($"../".chi_user_settings_path);
		$Label2.text = "writed:\n" + $"../".chi_user_settings_path;

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
	$"../".chi_user_BG_Color = Color($Color/ColorPicker.color);




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
