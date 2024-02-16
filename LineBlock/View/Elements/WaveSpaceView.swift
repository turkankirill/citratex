import SwiftUI
import SineWaveShape

struct WaveSpaceView: View {
    @Binding var progressPercentage: Double
    @State var pepep = 19.0
    var barCornerRadius: CGFloat = 10
    var barColors: [Color] = [Color.bLightRed]
    var barBackgroundColor: Color = Color.secondary.opacity(0.2)
    var percentageLabelColor: Color = Color.black
    var freeSpace: String
    var totalSpace: String
    
    var percentageString: String {
        String(format: "%0.f", progressPercentage)
    }
    
    var body: some View {
        HStack(spacing: 20) {
            WaveShieldedMemoriesVault(percent: $progressPercentage)
            
            
            VStack(spacing: 4) {
                VStack(alignment: .center) {
                    Text("Free space:")
                        .font(.workSans(.Regular, style: .headline))
                    Text("\(freeSpace)")
                        .font(.workSans(.Medium, style: .headline))
                }
                VStack(alignment: .center) {
                    Text("Total space:")
                        .font(.workSans(.Regular, style: .headline))
                    Text("\(totalSpace)")
                        .font(.workSans(.Medium, style: .headline))

                }
                
            }
            .frame(maxHeight: 200, alignment: .bottom)
            
        }
        .padding(.bottom)
    }
    
    private func getProgressGradientWidthShieldedMemoriesVault(progress: CGFloat, totalWidth: CGFloat) -> CGFloat {
        progress * totalWidth / 100
    }
}


struct WaveShieldedMemoriesVault: View {
    @State var phase: Double = 0
    let frequency: Double = 5
    let duration: Double = 3
    let  strength: Double = 15
    @Binding var percent: Double
    @State var circleLineWidth: CGFloat = 20.0
    var strokeColor = Color.bRobinEggBlue
    var color1 = Color.bRobinEggBlue
    var color2 = Color.bMintCream
    var color3 = Color.bRobinEggBlue
    var percentageString: String {
        String(format: "%0.f", percent)
    }
    var body: some View {
        VStack {
            Circle()
                .stroke(strokeColor, lineWidth: circleLineWidth)
                .background(
                    ZStack {
                        Color.bMintCream
                        SineWaveShape(percent: (100.0 - percent)/100, strength: strength * 0.9, frequency: frequency + 2, phase: self.phase)
                            .fill(color1)
                            .offset(y: CGFloat(1) * 1)
                            .animation(
                                Animation.linear(duration: duration).repeatForever(autoreverses: false)
                            )
                            .mask(
                                LinearGradient(gradient: Gradient(colors: [color1.opacity(0.7), color1]), startPoint: .top, endPoint: .bottom)
                            )
                        
                        SineWaveShape(percent: (100.0 - percent)/100, strength: strength * 0.8, frequency: frequency + 1, phase: self.phase)
                            .fill(color2)
                            .offset(y: CGFloat(2) * 1)
                            .animation(
                                Animation.linear(duration: percent).repeatForever(autoreverses: false)
                            )
                            .mask(
                                LinearGradient(gradient: Gradient(colors: [color2.opacity(0.7), color2]), startPoint: .top, endPoint: .bottom)
                            )
                        
                        SineWaveShape(percent: (100.0 - percent)/100, strength: strength * 0.7, frequency: frequency, phase: self.phase)
                            .fill(color3)
                            .offset(y: CGFloat(3) * 1)
                            .animation(
                                Animation.linear(duration: duration).repeatForever(autoreverses: false)
                            )
                            .mask(
                                LinearGradient(gradient: Gradient(colors: [color3.opacity(0.7), color3]), startPoint: .top, endPoint: .bottom)
                            )
                        
                        Text(percentageString + "%")
//                            .font(.custom(.medium, size: 16))
                            .foregroundColor(percent < 20 ? .red : .white)
                            .frame(maxHeight: .infinity, alignment: .bottom)
                            .padding(.bottom, percent < 20 ? 20 : percent)
                    }
                        .clipShape(Circle())
                        .onAppear(perform: {
                            phase = .pi * 2
                            print("percent \(percent)")
                            
                        })
                )
        }
        .frame(width: 200, height: 200)
    }
}

struct WaveSpaceView_Previews: PreviewProvider {
    static var previews: some View {
        WaveSpaceView(progressPercentage: .constant(50), freeSpace: "10 GB", totalSpace: "50 GB")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
