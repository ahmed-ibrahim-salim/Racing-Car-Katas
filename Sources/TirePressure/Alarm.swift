import ApprovalTests
import Foundation

public class Alarm {
    private let lowPressureThreshold: Double = 17
    private let highPressureThreshold: Double = 21

    let _sensor = Sensor()

    private var _alarmOn = false
    private var _alarmCount = 0

    public func check() {
        let psiPressureValue = getSensor().PopNextPressurePsiValue()
        print("value:", psiPressureValue)

        if psiPressureValue < lowPressureThreshold || highPressureThreshold < psiPressureValue {
            _alarmOn = true
            _alarmCount += 1
        }
    }

    public func getSensor() -> Sensor {
        return _sensor
    }

    public var alarmOn: Bool { _alarmOn }
}
