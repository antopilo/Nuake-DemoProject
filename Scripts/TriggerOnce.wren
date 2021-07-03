import "Nuake:ScriptableEntity" for ScriptableEntity
import "Nuake:Engine" for Engine
import "Nuake:Scene" for Scene, Trigger
import "Nuake:Math" for Vector3
import "Nuake:Input" for Input
import "Nuake:Physics" for Physics, CollisionResult

class TriggerOnce is ScriptableEntity {
    construct new() {
        _Triggered = false
    }

    init() {
    }

    update(ts) {
    }
    
    fixedUpdate(ts) {
        if(_Triggered == true) return
            
        var trigger = this.GetComponent("Trigger") 

        if(trigger.GetOverlappingBodyCount() > 0) {
            var bodies = trigger.GetOverlappingBodies()
            var brush = this.GetComponent("Brush")

            var isPlayer = bodies[0].HasComponent("CharacterController")
            if(isPlayer) {
                for(t in brush.GetTargets()) {
                    if(t.HasComponent("Script")) {
                        var triggerable = t.GetComponent("Script")
                        triggerable.trigger()
                    }
                } 
                _Triggered = true
            }
        }
    }

    exit() {

    }
}