import SwiftUI
import Foundation

public final class CardViewModel: ObservableObject, Equatable {
    
    public let id: Int
    @Published var symbol: String = ""
    @Published var color: Color = .cardBack
    @Published var isFlipped: Bool = true
    @Published var opacity: Double = 0
    public var text: String
    public var properSymbol: String
    
    public init(id: Int, symbol: String, text: String) {
        self.id = id
        self.properSymbol = symbol
        self.text = text
    }
    
    public static func == (lhs: CardViewModel, rhs: CardViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}

