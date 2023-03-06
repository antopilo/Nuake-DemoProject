import "Nuake:ScriptableEntity" for ScriptableEntity

class PlayerScript is ScriptableEntity {

    construct new() {
    }

    init() {
        Engine.Log("Player init")
    }

    update(ts) {
        
    }

    fixedUpdate(ts) {
        
    } 

    exit() {
        Engine.Log("Player exit")
    }
}
