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

func _process(delta):
	
	if Input.is_action_just_pressed("numb_0"):
		add_buffer("0");
	if Input.is_action_just_pressed("numb_1"):
		add_buffer("1");
	if Input.is_action_just_pressed("numb_2"):
		add_buffer("2");
	if Input.is_action_just_pressed("numb_3"):
		add_buffer("3");
	if Input.is_action_just_pressed("numb_4"):
		add_buffer("4");
	if Input.is_action_just_pressed("numb_5"):
		add_buffer("5");
	if Input.is_action_just_pressed("numb_6"):
		add_buffer("6");
	if Input.is_action_just_pressed("numb_7"):
		add_buffer("7");
	if Input.is_action_just_pressed("numb_8"):
		add_buffer("8");
	if Input.is_action_just_pressed("numb_9"):
		add_buffer("9");
	if Input.is_action_just_pressed("op_multiply"):
		add_buffer(" * ");
	if Input.is_action_just_pressed("op_divide"):
		add_buffer(" / ");
	if Input.is_action_just_pressed("ui_accept"):
		_on_result_pressed();
	if Input.is_action_just_pressed("backspace"):
		_on_result2_pressed();

func _on_result_pressed():
	main_string = buffer.split(" ");
	$Container/TextIO/Text_Input.text = str(main_string);
	
	if main_string.has("*") || main_string.has("/"):
		if main_string[1] == "*":
			result = float(main_string[0]) * float(main_string[2]);
		elif main_string[1] == "/":
			result = float(main_string[0]) / float(main_string[2]);
		$Container/TextIO/Text_Result.text = str(result);
	else:
		pass

func _on_result2_pressed():
	buffer = "";
	$Container/TextIO/Text_Input.text = str(buffer);

func add_buffer(numb):
	buffer = buffer + str(numb);
	$Container/TextIO/Text_Input.text = str(buffer);

func _on_Link_Blog_pressed():
	OS.shell_open("https://overclockers.ru/blog/Hard-Workshop");

func _on_Link_Git_pressed():
	OS.shell_open("https://github.com/Shedou/Chi-Calculator");
