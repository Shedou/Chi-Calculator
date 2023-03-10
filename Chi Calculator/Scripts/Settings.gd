extends Control

var data = {
	"Window_width" : 420,
	"Window_height" : 440
}
var settings_path = str(OS.get_executable_path().get_base_dir()) + "/Settings/User_Setings.cfg";
var executable_path = OS.get_executable_path().get_base_dir();

func _on_Settings_BTN_Close_pressed():
	visible = false;


func _on_Settings_BTN_Save_pressed():
	chi_save_settings();

func chi_save_settings():
	var settings = File.new();
	var dir = Directory.new();
	if dir.dir_exists(executable_path + "/Settings") == false:
		dir.open(executable_path);
		dir.make_dir("Settings");
		$Label.text = "dir create";
		$Label2.text = settings_path;
		$Label3.text = executable_path;
		
	if settings.file_exists(settings_path) == true:
		settings.open(settings_path, File.READ_WRITE);
		#settings.seek_end();
		settings.store_line(str(data));
		settings.close();
		
	if settings.file_exists(settings_path) == false:
		settings.open(settings_path, File.WRITE);
		settings.store_line(str(data));
		settings.close();
	#$"/root".set_size_override(true, Vector2(data.Window_width, data.Window_height), Vector2(0,0))
	
	ProjectSettings.set_setting("display/window/size/width", data.Window_width);
	ProjectSettings.set_setting("display/window/size/height", data.Window_height);
	ProjectSettings.save_custom("override.cfg");
	

	#VisualServer.viewport_set_vflip(get_tree().get_root().get_viewport_rid(), true);
	#OS.set_window_title("FU**!!!");
	
	#get_node("/root").get_viewport().set_size_override(true, Vector2(520, 540), Vector2(0,0));
	#self.set_size(Vector2(620, 540));
	#ProjectSettings.set_setting("display/window/size/width", data.Window_width);
	#get_viewport().set_size_override(true, Vector2(data.Window_width, data.Window_height), Vector2(0,0));
	#get_viewport().set_size_override_stretch(true);
	#VisualServer.viewport_set_size(get_tree().get_root().get_viewport_rid(), 500, 500);
	#VisualServer.viewport_set_msaa(get_tree().get_root().get_viewport_rid(),VisualServer.VIEWPORT_MSAA_DISABLED)
	#$"/root".size = Vector2(data.Window_width, data.Window_height);
	#$"/root".set_size_override(true, Vector2(data.Window_width, data.Window_height), Vector2(0,0))
