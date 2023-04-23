import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ViewModel
    var body: some View {
        VStack(alignment: .center) {
            switch viewModel.contentState {
            case .initial:
                Text("Empty view...")
            case .loading:
                ProgressView()
            case .loaded(let appliances):
                ApplianceListView(appliances: appliances)
            case .error:
                Text("Error view")
            }
        }.task {
            viewModel.reload()
        }
    }
}

// MARK: Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            viewModel: .init(
                dependencyContainer: DependencyContainer()
            )
        )
    }
}
