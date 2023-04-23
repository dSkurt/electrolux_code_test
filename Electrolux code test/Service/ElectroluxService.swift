import Foundation

// MARK: - ElectroluxOvenService

protocol ElectroluxOvenService {
    func fetchAppliance() async throws -> [Appliance]
}

extension ElectroluxServiceClient: ElectroluxOvenService {
    func fetchAppliance() async throws -> [Appliance] {
        try await fetch(name: "Oven")
    }
}

// MARK: - ElectroluxServiceClient
struct ElectroluxServiceClient {
    let jsonDecoder: JSONDecoder = JSONDecoder()
    func fetch<T: Decodable>(name: String) async throws -> [T] {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        guard let filePath = Bundle.main.path(forResource: name, ofType: "json") else {
            throw NSError()
        }
        
        let fileUrl = URL(fileURLWithPath: filePath)
        let data = try Data(contentsOf: fileUrl)
        let decodedData = try jsonDecoder.decode(T.self, from: data)
        return [decodedData]
    }
}
