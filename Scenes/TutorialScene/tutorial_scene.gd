extends Control

@onready var tb_main_scene: TextureButton = $TB_MainScene
const SCALE_VALUE = Vector2(1.1,1.1)
const DEFAULT_SCALE = Vector2(1.0,1.0)

@onready var en_info: Label = $En_INFO
@onready var en_info_2: Label = $En_INFO2
@onready var br_info_3: Label = $Br_INFO3
@onready var br_info_4: Label = $Br_INFO4

@onready var tb_translate_en: TextureButton = $MC/VBoxContainer/TB_TranslateEN
@onready var tb_translate_br: TextureButton = $MC/VBoxContainer/TB_TranslateBR


var en_infos = []
var br_infos = []

func _ready() -> void:
	en_infos = [en_info, en_info_2]
	br_infos = [br_info_3, br_info_4]

func _on_tb_main_scene_mouse_entered() -> void:
	tb_main_scene.scale = SCALE_VALUE


func _on_tb_main_scene_mouse_exited() -> void:
	tb_main_scene.scale = DEFAULT_SCALE


func _on_tb_main_scene_pressed() -> void:
	SceneManager.LoadMainScene()

func ShowEnInf()-> void:
	for br in br_infos:
		br.hide()
	for en in en_infos:
		en.show()
		
func ShowBrInfo() -> void:
	for br in br_infos:
		br.show()
	for en in en_infos:
		en.hide()


func _on_tb_translate_en_pressed() -> void:
	ShowEnInf()


func _on_tb_translate_br_pressed() -> void:
	ShowBrInfo()


func _on_tb_translate_en_mouse_entered() -> void:
	tb_translate_en.scale = SCALE_VALUE


func _on_tb_translate_en_mouse_exited() -> void:
	tb_translate_en.scale = DEFAULT_SCALE



func _on_tb_translate_br_mouse_entered() -> void:
	tb_translate_br.scale = SCALE_VALUE


func _on_tb_translate_br_mouse_exited() -> void:
	tb_translate_br.scale = DEFAULT_SCALE
