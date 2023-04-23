struct Appliance: Codable, Hashable {
    let applianceId: String
    let applianceData: ApplianceData
    let properties: ApplianceProperties
}

extension Appliance: Identifiable {
    var id: String { applianceId }
}

struct ApplianceData: Codable, Hashable {
    let applianceName: String
}

struct ApplianceProperties: Codable, Hashable {
    let doorState: String
    let temperatureRepresentation: Temperature
    let targetTemperature: Int
    let program: String
    let startTime: Int
    let targetDuration: Int
    let runningTime: Int
    let applianceState: ApplianceState
    let displayTemperature: Int
}

enum Temperature: String, Codable {
    case celsius = "CELSIUS"
    
    var description: String {
        switch self {
        case .celsius:
            return "°"
        }
    }
}

enum ApplianceState: String, Codable {
    case off = "READY_TO_START"

    var description: String {
        switch self {
        case .off:
            return "Off"
        }
    }
}
