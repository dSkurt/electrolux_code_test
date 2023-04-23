import SwiftUI

struct ApplianceListView: View {
    let appliances: [Appliance]
    var body: some View {
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
            }.navigationDestination(for: Appliance.self) { appliance in
                RemoteControlView(oven: appliance)
            }
            .navigationTitle("Home")
        }
    }
}
