import "Nuake:ScriptableEntity" for ScriptableEntity
import "Nuake:Engine" for Engine
import "Nuake:Scene" for Scene
import "Nuake:Math" for Vector3, Math
import "Nuake:Input" for Input

class CamScript is ScriptableEntity {
    construct new() {
       _Pitch = 0
       _Yaw = 0

       _mouseLastX = 0
       _mouseLastY = 0

        _BobLerp = 0.8
        _BobHeight = 0.5
        _BobSpeed = 0.1
        _CamHeightTarget = 0.5
        _CamHeight = _CamHeightTarget
        _deltaTime = 0

        _Sens = 0.1
        _LastCamHeight = _CamHeight
        Input.HideMouse()
    }

    init() {

    }

    update(ts) {
        var x = Input.GetMouseX()
        var my = Input.GetMouseY()

        var deltaX = (x - _mouseLastX) * _Sens
        var deltaY =  (_mouseLastY - my) * _Sens

        // Save positon for next update
        _mouseLastX = x
        _mouseLastY = my

        _Yaw = _Yaw + deltaX
        _Pitch = _Pitch + deltaY
        
        // Clamp up and down
        if(_Pitch > 89) _Pitch = 89
        if(_Pitch < -89) _Pitch = -89

        var rad_yaw = Math.Radians(_Yaw)
        var rad_pitch = Math.Radians(_Pitch)

        // Calculate forward vector
        // var camX = Math.Cos(rad_yaw) * Math.Cos(rad_pitch)
        // var camY = Math.Sin(rad_pitch)
        // var camZ = Math.Sin(rad_yaw) * Math.Cos(rad_pitch)
        // var newDir = Vector3.new(camX, camY, camZ)

        var player = Scene.GetEntity("Player")
        var playerTransform = player.GetComponent("Transform")
        var playerPosition = playerTransform.GetTranslation()
        var velocity = player.GetComponent("Script").GetVelocity()
        var bobValue = Math.Sin(_deltaTime * _BobSpeed * (velocity.Length() / 10.0))
        _CamHeight = Math.Lerp(_CamHeight, playerPosition.y + bobValue - (bobValue / 2.0)  *_BobHeight, _BobLerp)

        Engine.Log("%(playerPosition.x)")
        var transform = this.GetComponent("Transform")
        var newPos = Vector3.new(playerPosition.x, _CamHeight, playerPosition.z)
		var newRot = Vector3.new(-_Pitch, _Yaw, 0)
		transform.SetRotation(newRot)
        transform.SetTranslation(newPos)

        _deltaTime = _deltaTime + ts
    }

    fixedUpdate(ts) {
        
    }

    exit() {}
}