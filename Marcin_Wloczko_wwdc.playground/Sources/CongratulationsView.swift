import SwiftUI

public struct CongratulationsView: View {
    @Binding public var close: Bool
    
    @State public var scale: CGFloat = 1
    
    public var body: some View {
        ZStack {
            Color.background
            
            VStack {
                Spacer()
                
                Text("❤️")
                    .font(Font.system(size: 80))
                    .scaleEffect(scale)
                    .onAppear {
                        let baseAnimation =  Animation
                            .spring(response: 0.5, dampingFraction: 1)
                        let repeated = baseAnimation.repeatForever(autoreverses: true)
                        
                        return withAnimation(repeated) {
                            self.scale = 0.9
                        }
                }
                
                Spacer()
                
                Text("Congratulations!")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding([.top, .bottom])
                
                
                Text("You matched every single card!\nNow you know how important the immune system is and how to take care of it. Stay healthy!")
                    .font(.body)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Button(action: {
                    withAnimation(Animation.linear(duration: 0.2)) {
                        self.close = true
                    }
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.infoButton)
                            .frame(height: 48)
                        Text("Play again!")
                            .foregroundColor(Color.white)
                            .font(Font.bold(.callout)())
                    }
                }
                
                Spacer()
            }.padding(.all, 16)
        }.cornerRadius(10)
    }
}


 

