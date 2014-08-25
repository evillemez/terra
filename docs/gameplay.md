# Gameplay #

Confrontations play out on a 3d dynamic tile-based terrain area.  Combat is turn-based, though turn order is dynamic.

## Turn Mechanics & Time Cost ##

Each character is allowed to move and perform one action during a turn. Initial turn order is determined by the character's *initiative* stat.  Available actions include:

* Attacking with primary weapon
* Use a rune ability
* Use a consumable item
* Defend

A character may choose not to move if desired, and instead only perform one ability.  If a character only performs a *defend*, that's essentially skipping a turn with a low(ish) time cost.

All actions have a time cost, including movement.  The time cost can come in the form of *charge*, *cooldown*, or both.  All character turns and schedule actions are ordered in the event queue by lowest time cost first.

* *Charge* means an ability takes extra "turns" before it executes.
* *Cooldown* means the character must way extra "turns" before it can act after the ability executes.

### Event Queue ###

Underlyingly, character turn order is implemented in an event queue that is processed by time-ordered events.  There are several types of events that can enter the queue:

* Character turn events
* Character ability execution events
* Terrain events