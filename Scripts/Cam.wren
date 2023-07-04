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

        _BobHeight = 0.1
        _BobSpeed = 5.0
        _CamHeight = 0.5

        _deltaTime = 0

        Input.HideMouse()
    }

    init() {

    }

    update(ts) {
        var x = Input.GetMouseX()
        var my = Input.GetMouseY()

        var diffx = x - _mouseLastX
        var diffy =  _mouseLastY - my
        _mouseLastX = x
        _mouseLastY = my

        var sens = 0.1

        diffx = diffx * sens
        diffy = diffy * sens

        _Yaw = _Yaw + diffx
        _Pitch = _Pitch + diffy

        if(_Pitch > 89) _Pitch = 89
        if(_Pitch < -89) _Pitch = -89


        var rad_yaw = Math.Radians(_Yaw)
        var rad_pitch = Math.Radians(_Pitch)
        var camX = Math.Cos(rad_yaw) * Math.Cos(rad_pitch)
        var camY = Math.Sin(rad_pitch)
        var camZ = Math.Sin(rad_yaw) * Math.Cos(rad_pitch)

        var newDir = Vector3.new(camX, camY, camZ)

        var camTransform = this.GetComponent("Transform")
        var camPoss = camTransform.GetTranslation()

        var transform = this.GetComponent("Transform")
        //var newPos = Vector3.new(pPos.x, _CamHeight, pPos.z)
		var newRot = Vector3.new(-_Pitch, _Yaw, 0)
		transform.SetRotation(newRot)
    }

    fixedUpdate(ts) {
        _deltaTime = _deltaTime + ts
    }

    exit() {}
}