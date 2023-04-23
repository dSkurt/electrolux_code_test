import SwiftUI

@main
struct Electrolux_code_testApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                viewModel: .init(
                    dependencyContainer:  DependencyContainer()
                )
            )
        }
    }
}

struct DependencyContainer {
    let serviceClient: ElectroluxServiceClient
    
    init() {
        serviceClient = ElectroluxServiceClient()
    }
}
