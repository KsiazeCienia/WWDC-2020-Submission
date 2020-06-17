import SwiftUI

public struct GameView: View {
    
    @ObservedObject private var viewModel = GameViewModel()
    @State private var isWelcomeHidden: Bool = false
    private var firstSelectedCard: CardViewModel?
    private var secondSelectedCard: CardViewModel?
    
    public init() {}
    
    public var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.background)
            
            VStack {
                Spacer()
                
                Text("Let's go!")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .bold()
                    .padding([.bottom])
                    .opacity(viewModel.areTitlesVisible ? 1 : 0)
                
                Text("To win find all pairs of cards")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .opacity(viewModel.areTitlesVisible ? 1 : 0)
                
                Spacer()
                
                ForEach((0 ..< viewModel.cardViewModels.count)) { row in
                    HStack {
                        ForEach((0 ..< self.viewModel.cardViewModels[row].count)) { col in
                            CardView(viewModel: self.viewModel.cardViewModels[row][col])
                                .aspectRatio(1, contentMode: .fit)
                                .onTapGesture {
                                    self.viewModel.didSelectCard(row: row, col: col)
                            }
                        }
                    }
                }
                
                Spacer()
            }
            .allowsHitTesting(!viewModel.showInformation)
            .padding(16)
            
            Color.black
                .opacity(viewModel.showInformation ? 0.5 : 0)
            
            InformationView(
                viewModel: viewModel.informationViewModel,
                close: $viewModel.showInformation
            )
                .opacity(viewModel.showInformation ? 1 : 0)
                .frame(maxHeight: 300)
                .padding(32)
             
            
            WelcomeView(close: $viewModel.isWelcomeHidden, start: $isWelcomeHidden)
                .frame(maxHeight: 350)
                .opacity(isWelcomeHidden ? 0 : 1)
                .padding(8)
            
            CongratulationsView(close: $viewModel.resetGame)
                .frame(maxHeight: 420)
                .opacity(viewModel.showResult ? 1 : 0)
                .padding(8)
            
        }
        .allowsHitTesting(viewModel.isInteractionEnabled)
    }
}

