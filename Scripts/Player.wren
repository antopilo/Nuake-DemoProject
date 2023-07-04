import "Nuake:ScriptableEntity" for ScriptableEntity
import "Nuake:Engine" for Engine
import "Nuake:Input" for Input
import "Nuake:Math" for Vector3, Math
import "Nuake:Scene" for Scene

class PlayerScript is ScriptableEntity {

    construct new() {
    }

    init() {
        Engine.Log("Player init")
    }

    update(ts) {
        
    }

    fixedUpdate(ts) {
        var cam = Scene.GetEntity("Camera")
        var transformComponent = cam.GetComponent("Transform")
        var camDirection = cam.GetDirection()
        camDirection.y = 0.0
        camDirection = camDirection.Normalize()

        var speed = 100.0

        var velocity = Vector3.new(0.0, 0.0, 0.0)
        if(Input.IsKeyPressed(87)) {
            velocity.x = 1.0
        }

        if(Input.IsKeyPressed(65)) {
            velocity.z = -1.0
        }

        if(Input.IsKeyPressed(68)) {
            velocity.z = 1.0
        }

        if(Input.IsKeyPressed(83)) {
            velocity.x = -1.0
        }

        Engine.Log("Velocity: %(velocity.x), %(velocity.y), %(velocity.z)")
        velocity = velocity.Normalize()
        Engine.Log("Velocity: %(velocity.x), %(velocity.y), %(velocity.z)")
        velocity = velocity * Vector3.new(speed * ts, 1.0, speed * ts)
        Engine.Log("Velocity: %(velocity.x), %(velocity.y), %(velocity.z)")
        this.GetComponent("CharacterController").MoveAndSlide(velocity)
    } 

    exit() {
        Engine.Log("Player exit")
    }
}
