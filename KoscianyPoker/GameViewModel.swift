import Foundation
import SwiftUI
 
class GameViewModel: ObservableObject {
    
    @Published private var model = Game()
    
    var cardsPlayer: [CardModel] {
        return model.cardsPlayer
    }
    
    var cardsOpponent: [CardModel] {
        return model.cardsOpponent
    }

    var isFinished: Bool {
        return model.isFinished
    }
    
    var isRolled: Bool {
        return model.isRolled
    }
    
    var round: Int {
        return model.round
    }
    
    var opponentPoints: Int {
        return model.opponentPoints
    }
    
    var playerPoints: Int {
        return model.playerPoints
    }
    
    var isInfo: Bool {
        return model.isInfo
    }
    
    var isNextRound: Bool {
        return model.isNextRound
    }
    
    func choose(card: CardModel){
        model.choose(card)
    }
    
    func handleReroll(){
        model.handleReroll()
    }
    
    func handleNextRound(){
        model.handleNextRound()
    }
    
    func handleInfo(){
        model.handleInfo()
    }
    
    func handleRefresh(){
        model = Game()
    }
}
