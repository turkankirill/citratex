import SwiftUI

struct CustomToggle: View {
    var isOn: Bool
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(isOn ? Color.bRobinEggBlue : Color.bGunmetal.opacity(0.2))
            .frame(width: 60, height: 35)
            .overlay(alignment: isOn ? .trailing : .leading) {
                Circle()
                    .fill(isOn ? .white : .bRobinEggBlue)
                    .frame(width: 30)
                    .padding(.horizontal, 2)
                    
            }
            .animation(.easeInOut)
            
    }
}

//#Preview {
//    CustomToggle(isOn: true)
//}
