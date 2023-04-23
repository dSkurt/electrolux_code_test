import SwiftUI

struct RemoteControlView: View {
    let oven: Appliance
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            header
            Grid(alignment: .leading) {
                Text("Controls")
                GridRow() {
                    ControlItem(
                        imageString: "oven_icon",
                        title: "Function",
                        subtitle: oven.properties.program
                    )
                    ControlItem(
                        imageString: "temp_icon",
                        title: "Temperature",
                        subtitle: "\(oven.properties.targetTemperature) \(oven.properties.temperatureRepresentation.description)"
                    )
                }
            }
            .padding(.horizontal)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(
            Color(uiColor: .lightGray)
                .ignoresSafeArea()
        )
    }
}

extension RemoteControlView {
    var header: some View {
        HStack {
            VStack(spacing: 16) {
                Text(oven.applianceData.applianceName)
                Text(oven.properties.applianceState.description)
            }
            .padding(.leading)
            
            Spacer()
            Image("oven_half")
        }
    }
}

struct ControlItem: View {
    let imageString: String
    let title: String
    let subtitle: String
    var body: some View {
        VStack(spacing: 32) {
            Image(imageString)
            VStack(spacing: 16) {
                Text(title)
                Text(subtitle)
            }
        }
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity)
        .background{
            RoundedRectangle(cornerRadius: 8)
                .fill(
                    Color.white
                )
        }
    }
}
