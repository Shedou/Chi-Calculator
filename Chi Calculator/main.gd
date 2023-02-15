#Chi Calculator
#Copyright (C) 2023 Chimbal
#
#This program is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program.  If not, see <https://www.gnu.org/licenses/>.

extends Node2D

var main_renderX = 0;
var main_renderY = 0;

var result: float = 0.0;

var buffer: String = "";
var main_string = [];

#func _ready():
#	pass

func _process(delta):
	
	if Input.is_action_just_pressed("ui_up"):
		add_buffer("1");
#	main_renderX = OS.get_window_safe_area().size.x;
#	main_renderY = OS.get_window_safe_area().size.y;
#
#	$Write.margin_left = 20;
#	$Write.margin_right = main_renderX - 20;
#	$Write.margin_top = 20;
#	$Write.margin_bottom = main_renderY - 20;
#	yield(get_tree(), "idle_frame")

func _on_b1_pressed():
	add_buffer("1");

func _on_b2_pressed():
	add_buffer("2");

func _on_mult_pressed():
	add_buffer(" * ");

func _on_divis_pressed():
	add_buffer(" / ");

func _on_result_pressed():
	main_string = buffer.split(" ");
	$Write.text = str(main_string);
	
	if main_string.has("*") || main_string.has("/"):
		if main_string[1] == "*":
			result = float(main_string[0]) * float(main_string[2]);
		elif main_string[1] == "/":
			result = float(main_string[0]) / float(main_string[2]);
		$Out.text = str(result);
	else:
		pass

func _on_result2_pressed():
	buffer = "";
	$Write.text = str(buffer);

func add_buffer(numb):
	buffer = buffer + str(numb);
	$Write.text = str(buffer);
	


func _on_LinkButton_pressed():
	OS.shell_open("https://overclockers.ru/blog/Hard-Workshop");


func _on_LinkButton2_pressed():
	OS.shell_open("https://github.com/Shedou/Chi-Calculator");
