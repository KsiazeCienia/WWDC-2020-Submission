import Foundation

struct Resource {
    let symbol: String
    let text: String
}

struct GameBuilder {
    
    private let resource = [
        Resource(symbol: "🍒", text: "Eat fruits and vegetables everyday to fill your body with vitamins that will make you healthy!"),
        Resource(symbol: "🌒", text: "Your brain needs to recharge,\nso give it a break by sleeping at least 8 hours a day 💤"),
        Resource(symbol: "🚰", text: "Did you know that human body is mainly composed of water 🙉? Without water your body stops working properly, so drink a glass of it when you feel thirsty"),
        Resource(symbol: "🏀", text: "Playing sports is a great way to stay fit and have fun 🤸🏻‍♂️ When you're fit, your body works well and feels good."),
        Resource(symbol: "🧣", text: "Get dressed appropriately to the weather - a beanie on a winter day is like a helmet against diseases 🛡"),
        Resource(symbol: "🛁", text: "Take care of your hygiene. Brush your teeth 🦷 at least twice a day and wash your hands 🧼 before meals to avoid diseases.")
    ]
    
    func build(rows: Int, cols: Int) -> [[CardViewModel]] {
        let resourceCopy = Array(resource.shuffled()[0 ..< rows * cols / 2])
        let gameBoard = (resourceCopy + resourceCopy).shuffled().shuffled()
        let cards = gameBoard.enumerated().map { index, resource in
            return CardViewModel(id: index, symbol: resource.symbol, text: resource.text)
        }
        var game: [[CardViewModel]] = []
        var row: [CardViewModel] = []
        for i in 1 ... rows * cols {
            row.append(cards[i - 1])
            if i % cols == 0 {
                game.append(row)
                row = []
            }
        }
    
        return game
    }
}


