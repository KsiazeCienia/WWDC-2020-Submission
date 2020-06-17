import SwiftUI

public struct WelcomeView: View {
    @Binding public var close: Bool
    @Binding public var start: Bool
    
    public var body: some View {
        ZStack {
//            Color.informationBackground
            
            VStack {
                
                HStack {
                    Text("Hello")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    Text("👋")
                        .font(.largeTitle)
                        .rotation3DEffect(Angle(degrees: 180), axis: (x: 0, y: 1.0, z: 0.0))
                }
                
                Text("Welcome to the education game about immune system. The immune system helps to protect us against diseases caused by tiny invaders such as viruses and bacteria. Get ready to learn how to make it stronger and stay healthy!")
                    .font(.callout)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(height: 160)
                    .padding([.top, .bottom])
                
                Button(action: {
                    withAnimation(Animation.linear(duration: 0.2)) {
                        self.close = true
                        self.start.toggle()
                    }
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(red: 246/255, green: 212/255, blue: 120/255))
                            .frame(height: 48)
                        Text("Let's go!")
                            .foregroundColor(Color.white)
                            .font(Font.bold(.callout)())
                    }
                }
            }.padding(.all, 16)
        }.cornerRadius(10)
    }
}


