import SwiftUI

public struct InformationView: View {
    
    @ObservedObject var viewModel: InformationViewModel
    @Binding var close: Bool
    
    public init(viewModel: InformationViewModel, close: Binding<Bool>) {
        self.viewModel = viewModel
        self._close = close
    }
    
    public var body: some View {
        ZStack {
            Color.informationBackground
            
            VStack {
                Text(viewModel.title)
                    .font(.system(size: 50))
                
                Spacer()
                
                Text(viewModel.description)
                    .font(.body)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
                
                Button(action: {
                    withAnimation(Animation.linear(duration: 0.2)) {
                        self.close.toggle()
                    }
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.infoButton)
                            .frame(height: 48)
                        Text("Got it!")
                            .foregroundColor(Color.white)
                            .font(Font.bold(.callout)())
                    }
                }
            }.padding(.all, 16)
        }.cornerRadius(10)
    }
}

