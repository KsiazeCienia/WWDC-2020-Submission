import PlaygroundSupport
import SwiftUI

/*

 Welcome to the education game about immune system.
 The goal of the game is to find all pairs of cards

*/


let gameView = GameView()
let viewController = UIHostingController(rootView: gameView)
viewController.preferredContentSize = CGSize(width: 375, height: 734)
PlaygroundPage.current.liveView = viewController
