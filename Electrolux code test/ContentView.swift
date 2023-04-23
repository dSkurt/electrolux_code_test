import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            switch viewModel.contentState {
            case .initial:
                Text("Empty view")
            case .loading:
                ProgressView()
            case .loaded(let appliances):
                NavigationStack {
                    List(appliances) { appliance in
                        NavigationLink(
                            value: appliance,
                            label: {
                                VStack {
                                    Text(appliance.applianceData.applianceName)
                                    Image("oven")
                                    VStack {
                                        Text(appliance.properties.applianceState.description)
                                        Text("Tap to select function.")
                                    }
                                }
                                .frame(maxWidth: .infinity)
                            }
                        )
                    }.navigationDestination(for: Appliance.self) { oven in
                        RemoteControlView(oven: oven)
                    }
                    .navigationTitle("Home")
                }
            case .error:
                Text("Show error view")
            }
        }
        .task {
            viewModel.reload()
        }
    }
    
}

enum ContentState {
    case initial
    case loaded([Appliance])
    case loading
    case error
}

class ContentViewModel: ObservableObject {
    let dependencyContainer: DependencyContainer
    init(dependencyContainer: DependencyContainer) {
        self.dependencyContainer = dependencyContainer
    }
    
    @Published var contentState: ContentState = .initial
    
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            viewModel: .init(
                dependencyContainer: DependencyContainer()
            )
        )
    }
}
