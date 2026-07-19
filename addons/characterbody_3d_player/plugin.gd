@tool
extends EditorPlugin

const ACTIONS: Dictionary[String, EditorActionMapper.InputEventType] = {
	"forward": EditorActionMapper.INPUT_EVENT_TYPE_KEY,
	"left": EditorActionMapper.INPUT_EVENT_TYPE_KEY,
	"back": EditorActionMapper.INPUT_EVENT_TYPE_KEY,
	"right": EditorActionMapper.INPUT_EVENT_TYPE_KEY,
	"jump": EditorActionMapper.INPUT_EVENT_TYPE_KEY,
}
const EVENTS: Dictionary[String, Variant] = {
	"forward": KEY_W,
	"left": KEY_A,
	"back": KEY_S,
	"right": KEY_D,
	"jump": KEY_SPACE,
}


func _enable_plugin() -> void:
	var mapped: Array[String] = EditorActionMapper.bulk_map_actions(ACTIONS, EVENTS)
	var mapped_text: String = ""

	for action: String in mapped:
		mapped_text += "  - %s: %s\n" % [action, OS.get_keycode_string(EVENTS[action])]

	EditorNotifier.get_confirmation(
			"The following actions have been added to the input map of your "
			+ "project:\n%s" % mapped_text
			+ "These actions will not appear in the input map tab until "
			+ "another action is added or the editor is restarted.",
			"Save & Restart",
			"OK",
			EditorInterface.restart_editor.bind(true))


func _disable_plugin() -> void:
	var unmapped: Array[String] = EditorActionMapper.bulk_unmap_actions(ACTIONS.keys())
	var unmapped_text: String = ""

	for action: String in unmapped:
		unmapped_text += "  - %s: %s\n" % [action, OS.get_keycode_string(EVENTS[action])]

	EditorNotifier.get_confirmation(
			"The following actions have been removed from the input map of your "
			+ "project:\n%s" % unmapped_text
			+ "These actions will not disappear from the input map tab until "
			+ "another action is added or the editor is restarted.",
			"Save & Restart",
			"OK",
			EditorInterface.restart_editor.bind(true))
