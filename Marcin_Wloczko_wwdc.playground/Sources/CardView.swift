import SwiftUI

struct CardView: View {
    
    @ObservedObject var viewModel: CardViewModel
    private let cover: String = "❔"
    
    var body: some View {
        let flipDegrees = viewModel.isFlipped ? 180.0 : 0
        
        return ZStack {
            ZStack {
                viewModel.color
                    .cornerRadius(10)
                
                Text(viewModel.symbol)
                    .font(.system(size: 50))
            }
            .flipRotate(-180 + flipDegrees)
            .opacity(viewModel.isFlipped ? 1 : 0)
                
            ZStack {
                Color.cardBack
                    .cornerRadius(10)
                
                Text(cover)
                    .font(.system(size: 50))
            }
            .flipRotate(flipDegrees)
            .opacity(viewModel.isFlipped ? 0 : 1)
                
        }
        .opacity(viewModel.opacity)
    }
}

extension View {
    
    func flipRotate(_ degrees : Double) -> some View {
        return rotation3DEffect(Angle(degrees: degrees), axis: (x: 1.0, y: 0.0, z: 0.0))
    }
}


