import "Nuake:Engine" for Engine
import "Nuake:ScriptableEntity" for ScriptableEntity


class TestScript is ScriptableEntity {
    construct new() {
        _deltaTime = 0
    }

    init() {
        Engine.Log("Hello init")
    }

    update(ts) {
        _deltaTime = _deltaTime + ts


    }

    fixedUpdate(ts) {
        
    }

    exit() {
        Engine.Log("Hello exit")
    }
}