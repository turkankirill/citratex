
import SwiftUI

struct BlockAdultButtonView: View {
    @EnvironmentObject var blockerViewModel: ContentblockersViewModel
    @State var isToggleOn = false
    var body: some View {
        VStack(alignment: .leading) {
            Image("age-limit")
                .resizable()
                .scaledToFit()
                .frame(width: 40)
            
            Text("Block Adult\nsites")
                .font(.workSans(.SemiBold, style: .headline))
                .foregroundColor(.bRobinEggBlue)
                .lineLimit(2)
                .frame(maxHeight: 100)
            
            CustomToggle(isOn: blockerViewModel.blockers[2].state)
                .onTapGesture {
                    blockerViewModel.switchBlocker(title: blockerViewModel.blockers[2].title)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 170)
        .background(RoundedRectangle(cornerRadius: 30, style: .continuous)
            .fill(.white)
            .shadow(color: .bRobinEggBlue.opacity(0.3), radius: 10))
        .padding(.leading, 6)
    }
}

