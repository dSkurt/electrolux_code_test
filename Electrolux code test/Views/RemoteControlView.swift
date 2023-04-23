import SwiftUI

struct RemoteControlView: View {
    let oven: Appliance
    var body: some View {
        VStack {
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
            
            footer
        }
        .background(
            Color(uiColor: .lightGray)
                .ignoresSafeArea()
        )
    }
}

// MARK: - Private views
private extension RemoteControlView {
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
    
    @ViewBuilder
    var footer: some View {
        Spacer()
        Button(
            "TURN ON",
            action: { }
        )
        .frame(width: 224, height: 48)
        .background(.blue)
        .cornerRadius(14)
        .foregroundColor(.white)
    }
}

private struct ControlItem: View {
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
