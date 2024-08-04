extends RigidBody2D

enum ANIMAL_STATE { READY , DRAG , RELEASED }

var state : ANIMAL_STATE = ANIMAL_STATE.READY

const DRAG_LIM_MAX : Vector2 = Vector2(0, 60)
const DRAG_LIM_MIN : Vector2 = Vector2(-60,0)
const IMPULSE_MULT : float = 20.0
const IMPULSE_MAX : float = 1200.0

var start : Vector2 = Vector2.ZERO
var dragStart : Vector2 = Vector2.ZERO
var draggedVector : Vector2 = Vector2.ZERO	
var lastDraggedVector : Vector2 = Vector2.ZERO
var arrowScaleX : float = 0.0
var lastCollisionCount : int = 0

@onready var debug_state_label: Label = $DebugStateLabel
@onready var strechSound: AudioStreamPlayer2D = $StrechSound
@onready var arrow: Sprite2D = $Arrow
@onready var launchSound: AudioStreamPlayer2D = $LaunchSound
@onready var kick_sound: AudioStreamPlayer2D = $KickSound
@onready var out_of_bounds_counter: Timer = $OutOfBoundsCounter


func _ready() -> void:
	SignalManager.on_level_complete.connect(GameCompletedSequence)
	arrowScaleX = arrow.scale.x
	arrow.hide()
	start = position
	
func _physics_process(delta: float) -> void:
	Update(delta)

func GetImpulse() -> Vector2:
	var impulseAmount = draggedVector * -1 * IMPULSE_MULT
	return impulseAmount

func ReleaseSequence() -> void:
	freeze = false
	arrow.hide()
	apply_central_impulse(GetImpulse())
	launchSound.play()
	SignalManager.on_attempt_made.emit()

func SetNewState(newState : ANIMAL_STATE ) -> void:
	state = newState
	if state == ANIMAL_STATE.RELEASED:
		ReleaseSequence()
	elif state == ANIMAL_STATE.DRAG:
		dragStart = get_global_mouse_position()
		arrow.show()

func DetectRelease() -> bool:
	if state == ANIMAL_STATE.DRAG:
		if Input.is_action_just_released("clickNDrag"):
			SetNewState(ANIMAL_STATE.RELEASED)
			return true
	return false

func ScaleArrow() -> void:
	
	var impulse_len = GetImpulse().length()
	var percentage = impulse_len / IMPULSE_MAX
	var arrowValue = (arrowScaleX * percentage) + arrowScaleX
	const MAXSCALEVALUE = 0.6
	if arrowValue < MAXSCALEVALUE:
		arrow.scale.x = arrowValue
	arrow.rotation = (start - position).angle()


func PlayStrechSound() -> void:
	if (lastDraggedVector - draggedVector).length() > 0:
		if !strechSound.playing:
			strechSound.play()

func GetDraggedVector(gmp : Vector2) -> Vector2:
	return gmp - dragStart
	
func DragInLimits() -> void:
	
	lastDraggedVector = draggedVector
	
	draggedVector.x = clampf(draggedVector.x, DRAG_LIM_MIN.x, DRAG_LIM_MAX.x)
	draggedVector.y = clampf(draggedVector.y, DRAG_LIM_MIN.y, DRAG_LIM_MAX.y)
	position = start + draggedVector
	
func UpdateDrag() -> void:
	
	if DetectRelease():
		return
	
	var gmp = get_global_mouse_position()
	draggedVector = GetDraggedVector(gmp)
	PlayStrechSound()
	ScaleArrow()
	DragInLimits()

func PlayCollision() -> void:
	if (lastCollisionCount == 0 and get_contact_count() > 0 and kick_sound.playing == false):
		kick_sound.play()
	lastCollisionCount = get_contact_count()
	
func UpdateFlight() -> void:
	PlayCollision()

func Update(delta : float) -> void:
	match state:
		ANIMAL_STATE.DRAG:
			UpdateDrag()
		ANIMAL_STATE.RELEASED:
			UpdateFlight()

func Death() -> void:
	SignalManager.on_animal_death.emit()
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	out_of_bounds_counter.start()


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if state == ANIMAL_STATE.READY and event.is_action_pressed("clickNDrag"):
		SetNewState(ANIMAL_STATE.DRAG)


func _on_sleeping_state_changed() -> void:
	if sleeping:
		var cb = get_colliding_bodies()
		if cb.size() > 0:
			cb[0].CupVanish()
		call_deferred("Death")

func GameCompletedSequence() -> void:
	set_physics_process(false)

func _on_out_of_bounds_counter_timeout() -> void:
	Death()

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	out_of_bounds_counter.stop()
	
