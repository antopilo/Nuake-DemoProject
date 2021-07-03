
import "Nuake:ScriptableEntity" for ScriptableEntity

class Triggerable is ScriptableEntity {
    construct new() {
        _Triggered = false
    }

    init() {
    }

    update(ts) {
    }
    
    fixedUpdate(ts) {
    }

    exit() {

    }

    trigger() {
        _Triggered = true
    }
}