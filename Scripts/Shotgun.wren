import "Nuake:Engine" for Engine
import "Nuake:ScriptableEntity" for ScriptableEntity
import "Nuake:Input" for Input
import "Nuake:Scene" for Scene

class Shotgun is ScriptableEntity {
    construct new() {
        _ReloadSpeed = 0.1
        _Intensity = 0.0
    }

    init() {
    }

    update(ts) {
        
    }

    fixedUpdate(ts) {
        var muzzle = Scene.GetEntity("MuzzleFlash")
        var light = muzzle.GetComponent("Light")
        if(Input.IsMouseButtonPressed(0)) {
            _Intensity = 35
        }

        _Intensity = _Intensity - (250 * ts)

        if(_Intensity > 0) {
            light.SetIntensity(_Intensity)
        } else {
            light.SetIntensity(0)
        }

    }

    exit() {
    }
}