extends Node

var current_level: int = 1
var current_level_root: Node = null
# 0 = main menu and 1st dialogue
# 1 = levels and next dialogue
# 3 = endgame
var gameplay_state: int = 0

var fucking_around: int = 0
var memory: int = 0
var provoke: int = 0
var promised: bool = false
