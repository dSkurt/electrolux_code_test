import SwiftUI

extension ContentView {
    final class ViewModel: ObservableObject {
        @Published private(set) var contentState: ContentState = .initial
        let dependencyContainer: DependencyContainer
        
        init(dependencyContainer: DependencyContainer) {
            self.dependencyContainer = dependencyContainer
        }
        
        func reload() {
            Task { @MainActor in
                contentState = .loading
                do {
                    let appliances = try await dependencyContainer.serviceClient.fetchAppliance()
                    contentState = .loaded(appliances)
                } catch {
                    contentState = .error
                }
            }
        }
    }
}

extension ContentView.ViewModel {
    enum ContentState {
        case initial
        case loaded([Appliance])
        case loading
        case error
    }
}
