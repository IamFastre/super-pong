class_name PlayerInfo extends Resource

enum ID {
    P1,
    P2,
}

@export var name:String
@export var score:int = 0
@export var is_human:bool
@export var id:ID = ID.P1
