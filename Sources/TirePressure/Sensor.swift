import Foundation

// open closed principle violation

protocol SensorProtocol {
    func PopNextPressurePsiValue() -> Double
}

public class Sensor: SensorProtocol {
    let offset: Double = 16

    func PopNextPressurePsiValue() -> Double {
        var pressureTelemetryValue: Double = 0

        Self.samplePressure(&pressureTelemetryValue)

        return offset + pressureTelemetryValue
    }

    private static func samplePressure(_ pressureTelemetryValue: inout Double) {
        pressureTelemetryValue = 6 * Double.random(in: 0 ..< 1) * Double.random(in: 0 ..< 1)
    }
}
