import "Scripts/Triggerable" for Triggerable
import "Nuake:ScriptableEntity" for ScriptableEntity
import "Nuake:Engine" for Engine

class Door is Triggerable {
    construct new() {
        _Triggered = false
        _Opening = false
        _StartY = 0
    }

    init() {
        var transform = this.GetComponent("Transform")
        var pos = transform.GetTranslation()
        _StartY = pos.y
    }

    update(ts) {
    }
    
    fixedUpdate(ts) {
        if(_Opening == true) {
            var transform = this.GetComponent("Transform")
            var pos = transform.GetTranslation()
            pos.y = pos.y + 1.0 * ts
            
            transform.SetTranslation(pos)
            if(pos.y >= _StartY + 1.5) {
                _Opening = false
            }
        }
    }

    exit() {

    }

    trigger() {
        _Triggered = true
        _Opening = true
        Engine.Log("TRIGGERED!")
    }
}