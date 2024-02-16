
import SwiftUI

struct BlockWebTrackersView: View {
    @EnvironmentObject var blockerViewModel: ContentblockersViewModel
//    @State var isToggleOn = false
    var body: some View {
        VStack(alignment: .leading) {
            Image("arrows")
                .resizable()
                .scaledToFit()
                .frame(width: 40)
            
            Text("Block web\ntrackers")
                .font(.workSans(.SemiBold, style: .headline))
                .foregroundColor(.bRobinEggBlue)
                .lineLimit(2)
                .frame(maxHeight: 100)
            
            CustomToggle(isOn: blockerViewModel.blockers[1].state)
                .onTapGesture {
                    blockerViewModel.switchBlocker(title: blockerViewModel.blockers[1].title)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 170)
        .background(RoundedRectangle(cornerRadius: 30, style: .continuous)
            .fill(.white)
            .shadow(color: .bRobinEggBlue.opacity(0.3), radius: 10))
        .padding(.trailing, 6)
    }
}
