import SwiftUI

public final class GameViewModel: ObservableObject {
    private struct Timing {
        static let flipTime: Double = 0.2
        static let watchTime: Double = 0.5
        static let changeColorTime: Double = 0.2
        static let changeColorDelay: Double = 0.3
        static let showInfoTime: Double = 0.2
        static let showResult: Double = 0.2
    }
    
    private struct Game {
        static let rows: Int = 4
        static let cols: Int = 3
        static let pairs: Int = 6
    }
    
    @Published var informationViewModel: InformationViewModel = InformationViewModel(title: "", description: "")
    @Published var showInformation: Bool = false
    @Published var isInteractionEnabled: Bool = true
    @Published var cardViewModels: [[CardViewModel]] = GameBuilder().build(rows: Game.rows, cols: Game.cols)
    @Published var showResult: Bool = false
    @Published var resetGame: Bool = false
    @Published var isWelcomeHidden: Bool = false
    @Published var areTitlesVisible: Bool = false
    
    private var firstSelectedCard: CardViewModel?
    private var secondSelectedCard: CardViewModel?
    private var timer: Timer?
    private var resolved: Int = 0
    
    private var check: Any?
    private var resultCheck: Any?
    private var welcomeCheck: Any?
    
    public init() {
        setupBinding()
    }
    
    public func didSelectCard(row: Int, col: Int) {
        let selectedCard = cardViewModels[row][col]
        withAnimation(Animation.linear(duration: Timing.flipTime)) {
            selectedCard.isFlipped.toggle()
        }
        
        // If two are selected
        if let firstCard = firstSelectedCard, let secondCard = secondSelectedCard {
            let cardsToFlip = [firstCard, secondCard]
            firstSelectedCard = selectedCard
            secondSelectedCard = nil
            withAnimation(Animation.linear(duration: Timing.flipTime)) {
                cardsToFlip.forEach { $0.isFlipped.toggle() }
            }
            return
        }
        
        guard
            selectedCard != firstSelectedCard,
            selectedCard != secondSelectedCard
            else { return }
    
        if let firstCard = firstSelectedCard {
            guard firstCard.symbol == selectedCard.symbol else {
                firstSelectedCard = nil
                flipBack(cards: [firstCard, selectedCard])
                return
            }
            
            resolved += 1
            isInteractionEnabled.toggle()
            secondSelectedCard = selectedCard
            withAnimation(Animation.linear(duration: Timing.changeColorTime).delay(Timing.changeColorDelay)) {
                firstCard.color = .correctAnswer
                selectedCard.color = .correctAnswer
            }
            
            // Display information
            informationViewModel = InformationViewModel(
                title: selectedCard.symbol,
                description: selectedCard.text
            )
            let infoDelay = Timing.changeColorDelay + Timing.changeColorTime
            withAnimation(Animation.linear(duration: Timing.showInfoTime).delay(infoDelay)) {
                showInformation.toggle()
                firstCard.opacity = 0
                selectedCard.opacity = 0
            }
            timer = Timer.scheduledTimer(withTimeInterval: infoDelay + Timing.showInfoTime, repeats: false) { _ in
                self.isInteractionEnabled.toggle()
                self.timer?.invalidate()
            }
            firstSelectedCard = nil
            secondSelectedCard = nil
            
        } else {
            firstSelectedCard = selectedCard
        }
    }
    
    private func flipBack(cards: [CardViewModel]) {
        isInteractionEnabled = false
        timer = Timer.scheduledTimer(withTimeInterval: Timing.watchTime, repeats: false) { _ in
            self.isInteractionEnabled = true
            withAnimation(.linear(duration: Timing.flipTime)) {
                cards.forEach { $0.isFlipped.toggle() }
            }
            self.timer?.invalidate()
        }
    }
    
    private func setupBinding() {
        check = $showInformation.sink { [weak self] isShown in
            if isShown { return }
            self?.checkWin()
        }
        resultCheck = $resetGame.sink { [weak self] isReset in
            guard isReset else { return }
            self?.showResult = false
            self?.newGame()
        }
        welcomeCheck = $isWelcomeHidden.sink { [weak self] isHidden in
            guard isHidden else { return }
            self?.showCards()
        }
    }
    
    private func showCards() {
        let delay: Double = 0.2
        withAnimation(Animation.linear(duration: Timing.flipTime).delay(delay)) {
            self.areTitlesVisible = true
        }
        for i in 0 ..< cardViewModels.count {
            for j in 0 ..< cardViewModels[i].count {
                withAnimation(Animation.linear(duration: Timing.flipTime).delay(delay * Double(i))) {
                    cardViewModels[i][j].opacity = 1
                    cardViewModels[i][j].isFlipped = false
                }
                withAnimation(Animation.linear(duration: 0.1).delay(delay * Double(i) + Timing.flipTime + 0.1)) {
                    cardViewModels[i][j].color = .cardFront
                    cardViewModels[i][j].symbol = cardViewModels[i][j].properSymbol
                }
            }
        }
    }
    
    private func checkWin() {
        guard resolved == Game.pairs else { return }
        withAnimation(.linear(duration: Timing.showResult)) {
            self.showResult = true
            self.areTitlesVisible = false
        }
    }
    
    private func newGame() {
        resolved = 0
        firstSelectedCard = nil
        secondSelectedCard = nil
        
        let newCards = GameBuilder().build(rows: Game.rows, cols: Game.cols)
        let delay: Double = 0.2
        withAnimation(Animation.linear(duration: Timing.flipTime).delay(delay)) {
            self.areTitlesVisible = true
        }
        for i in 0 ..< cardViewModels.count {
            for j in 0 ..< cardViewModels[i].count {
                withAnimation(Animation.linear(duration: Timing.flipTime).delay(delay * Double(i))) {
                    cardViewModels[i][j].symbol = ""
                    cardViewModels[i][j].color = .cardBack
                    cardViewModels[i][j].opacity = 1
                    cardViewModels[i][j].isFlipped = false
                }
                withAnimation(Animation.linear(duration: 0.1).delay(delay * Double(i) + Timing.flipTime + 0.1)) {
                    cardViewModels[i][j].color = .cardFront
                    cardViewModels[i][j].properSymbol = newCards[i][j].properSymbol
                    cardViewModels[i][j].symbol = newCards[i][j].properSymbol
                }
            }
        }
    }
}


