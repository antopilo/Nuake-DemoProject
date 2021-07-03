import "Nuake:ScriptableEntity" for ScriptableEntity
import "Nuake:Engine" for Engine
import "Nuake:Scene" for Scene, Trigger
import "Nuake:Math" for Vector3
import "Nuake:Input" for Input
import "Nuake:Physics" for Physics, CollisionResult

class TriggerScript is ScriptableEntity {
    construct new() {
        _Activated = false
    }

    init() {
    }

    update(ts) {
    }
    
    fixedUpdate(ts) {
        var trigger = this.GetComponent("Trigger") 

        if(trigger.GetOverlappingBodyCount() > 0) {
            var bodies = trigger.GetOverlappingBodies()
            var brush = this.GetComponent("Brush")
            var isPlayer = bodies[0].HasComponent("CharacterController")
            if(isPlayer) {
                _Activated = true
            }
        }
        if(_Activated) {
            var brush = this.GetComponent("Brush")
            for(t in brush.GetTargets()) {
                var transform = t.GetComponent("Transform")
                var pos = transform.GetTranslation()

                pos.x = pos.x + 1.0 * ts
                
                transform.SetTranslation(pos)
            } 
        }
    }

    exit() {

    }
}