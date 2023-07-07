import "Nuake:ScriptableEntity" for ScriptableEntity
import "Nuake:Engine" for Engine
import "Nuake:Input" for Input
import "Nuake:Math" for Vector3, Math
import "Nuake:Scene" for Scene

class PlayerScript is ScriptableEntity {

    construct new() {
        _Input = Vector3.new(0.0, 0.0, 0.0)
        _Velocity = Vector3.new(0.0, 0.0, 0.0)
        Input.HideMouse()
    }

    init() {
        Engine.Log("Player init")
    }

    update(ts) {
        
    }

    fixedUpdate(ts) {
        var cam = Scene.GetEntity("Camera")
        var camComponent = cam.GetComponent("Camera")
        var transformComponent = cam.GetComponent("Transform")
        var camDirection = camComponent.GetDirection()
        camDirection.y = 0.0
        camDirection = camDirection.Normalize()

        var camTransform = cam.GetComponent("Transform")
        var camRotation = camTransform.GetRotation()
        camRotation.z = _Input.x * 0.5
        camTransform.SetRotation(camRotation)

        var camRight = camComponent.GetRight()

        var speed = 75.0

        if(Input.IsKeyPressed(87)) {
            _Input.z = 1.0
        } else if(Input.IsKeyPressed(83)) {
            _Input.z = -1.0
        } else {
            _Input.z = 0.0
        }

        if(Input.IsKeyPressed(65)) {
            _Input.x = 1.0
        } else if(Input.IsKeyPressed(68)) {
            _Input.x = -1.0
        } else {
            _Input.x = 0.0
        }
        
        var gravity = 12.0

        var characterController = this.GetComponent("CharacterController")
        var isOnGround = characterController.IsOnGround()
        if(isOnGround == false) {
            _Velocity.y = _Velocity.y - gravity * ts
        } else {
            _Velocity.y = -1
        }

        var jumpForce = 4
        if(Input.IsKeyPressed(32) && isOnGround) {
            _Velocity.y = jumpForce
        }

        //Engine.Log("Is on ground: %(characterController.IsOnGround())")

        _Input = _Input.Normalize()

        _Velocity = _Velocity + (camRight * _Input.x * speed * ts)
        _Velocity = _Velocity + (camDirection * _Input.z * speed * ts)

        // If grounded
        // Gravity
        var friction = 0.5
        _Velocity.x = _Velocity.x * friction
        _Velocity.z = _Velocity.z * friction

        // Engine.Log("Velocity: %(velocity.x), %(velocity.y), %(velocity.z)")
        characterController.MoveAndSlide(_Velocity)
    } 

    exit() {
        Engine.Log("Player exit")
    }

    GetVelocity() {
        return _Velocity
    }
}
