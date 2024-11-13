@testable import TirePressure
import XCTest

final class AlarmTests: XCTestCase {
    func testAlarmIsOffByDefault() {
        let alarm = TestableAlarm()

        XCTAssertFalse(alarm.alarmOn)
    }

    func testPressureAlarmIsOffWhenPressureIsInTheAllowedPressureRange() {
        let alarm = getAlarm(18.0)

        alarm.check()

        XCTAssertFalse(alarm.alarmOn)
    }

    func testPressureAlarmIsOnWhenPressureIsMoreThanAllowedPressure() {
        let alarm = getAlarm(22.0)

        alarm.check()

        XCTAssertTrue(alarm.alarmOn)
    }

    func testPressureAlarmIsOnWhenPressureIsLessThanAllowedPressure() {
        let alarm = getAlarm(16.0)

        alarm.check()

        XCTAssertTrue(alarm.alarmOn)
    }

    // add boundry test for the range
    func testPressureAlarmIsOffWhenPressureIsAtAllowedPressureBoundary() {
        let alarm = getAlarm(21.0)

        alarm.check()

        XCTAssertFalse(alarm.alarmOn)
    }
}

extension AlarmTests {
    func getAlarm(_ pressure: Double) -> TestableAlarm {
        let sensor = SensorStub(pressure: pressure)
        return TestableAlarm(sensor)
    }
}

class TestableAlarm: Alarm {
    let sensor: SensorStub
    init(_ sensor: SensorStub = SensorStub()) {
        self.sensor = sensor
    }

    override func getSensor() -> Sensor {
        return sensor
    }
}

class SensorStub: Sensor {
    var pressureTelemetryValue: Double
    init(pressure: Double = 0.0) {
        pressureTelemetryValue = pressure
    }

    override func PopNextPressurePsiValue() -> Double {
        pressureTelemetryValue
    }
}
