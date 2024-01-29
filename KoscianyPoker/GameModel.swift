import Foundation
import SwiftUI

struct Game: Equatable {
    var cardsPlayer: [CardModel] = [CardModel]()
    var cardsOpponent: [CardModel] = [CardModel]()
    var isFinished: Bool = false
    var isRolled: Bool = false
    var round: Int = 1
    var playerPoints: Int = 0
    var opponentPoints: Int = 0
    var isInfo: Bool = false
    var isNextRound: Bool = false
    
    init() {
        for i in 0..<5 {
            cardsPlayer.append(CardModel(number: Int.random(in: 1..<7), isEditable: true, isTapped: false, index: i))
        }
        for i in 0..<5 {
            cardsOpponent.append(CardModel(number: Int.random(in: 1..<7), isEditable: false, isTapped: false, index: i))
        }
    }
    
    mutating func choose(_ card: CardModel) {
        if(card.isEditable && isFinished == false) {
            cardsPlayer[card.index].isTapped = !cardsPlayer[card.index].isTapped
        }
    }
    
    mutating func handleReroll() {
        for i in 0..<5 {
            if (cardsPlayer[i].isTapped){
                cardsPlayer[i].isTapped = false
                cardsPlayer[i].number = Int.random(in: 1..<7)
            }
        }
        isRolled = true
    }
    
    mutating func handleNextRound() {
        validateRound()
        isRolled = false
        isNextRound = !isNextRound
        for i in 0..<5 {
                cardsPlayer[i].isTapped = false
                cardsPlayer[i].number = Int.random(in: 1..<7)
        }
        for i in 0..<5 {
                cardsOpponent[i].number = Int.random(in: 1..<7)
        }
        round+=1
    }
    
    mutating func validateRound() {
        let playerSortedNumbers = cardsPlayer.map { $0.number }.sorted()
        let opponentSortedNumbers = cardsOpponent.map { $0.number }.sorted()
        var playerRoundPoints = 0
        var opponentRoundPoints = 0
        
        if isPoker(playerSortedNumbers) {
            playerRoundPoints += 8
        } else if isKareta(playerSortedNumbers) {
            playerRoundPoints += 7
        } else if isFull(playerSortedNumbers) {
            playerRoundPoints += 6
        } else if isDużyStrit(playerSortedNumbers) {
            playerRoundPoints += 5
        } else if isMałyStrit(playerSortedNumbers) {
            playerRoundPoints += 4
        } else if isTrojka(playerSortedNumbers) {
            playerRoundPoints += 3
        } else if isDwiePary(playerSortedNumbers){
            playerRoundPoints += 2
        } else if isPara(playerSortedNumbers) {
            playerRoundPoints += 1
        }
        
        if isPoker(opponentSortedNumbers) {
            opponentRoundPoints += 8
        } else if isKareta(opponentSortedNumbers) {
            opponentRoundPoints += 7
        } else if isFull(opponentSortedNumbers) {
            opponentRoundPoints += 6
        } else if isDużyStrit(opponentSortedNumbers) {
            opponentRoundPoints += 5
        } else if isMałyStrit(opponentSortedNumbers) {
            opponentRoundPoints += 4
        } else if isTrojka(opponentSortedNumbers) {
            opponentRoundPoints += 3
        } else if isDwiePary(opponentSortedNumbers){
            opponentRoundPoints += 2
        } else if isPara(opponentSortedNumbers) {
            opponentRoundPoints += 1
        }
        
        if (playerRoundPoints > opponentRoundPoints){
            playerPoints += 1
        }
        else if (playerRoundPoints < opponentRoundPoints){
            opponentPoints += 1
        }
        
        if playerPoints == 3 || opponentPoints == 3 {
            isFinished = true
        }
    }
    func isPoker(_ numbers: [Int]) -> Bool {
        return Set(numbers).count == 1
    }

    func isKareta(_ numbers: [Int]) -> Bool {
        for count in numbers {
            if numbers.filter({ $0 == count }).count >= 4 {
                return true
            }
        }
        return false
    }

    func isFull(_ numbers: [Int]) -> Bool {
            let uniqueNumbers = Set(numbers)
            return uniqueNumbers.count == 2 && numbers.filter { $0 == numbers[0] }.count != 1
        }

    func isDużyStrit(_ numbers: [Int]) -> Bool {
        return Set(numbers) == Set([2, 3, 4, 5, 6])
    }

    func isMałyStrit(_ numbers: [Int]) -> Bool {
        return Set(numbers) == Set([1, 2, 3, 4, 5])
    }
    
    func isTrojka(_ numbers: [Int]) -> Bool {
            for count in numbers {
                if numbers.filter({ $0 == count }).count >= 3 {
                    return true
                }
            }
            return false
        }

    func isDwiePary(_ numbers: [Int]) -> Bool {
        var pairCount = 0
        for count in numbers {
            if numbers.filter({ $0 == count }).count >= 2 {
                pairCount += 1
            }
        }
        return pairCount == 4
    }

    func isPara(_ numbers: [Int]) -> Bool {
        for count in numbers {
            if numbers.filter({ $0 == count }).count >= 2 {
                return true
            }
        }
        return false
    }
    
    mutating func handleInfo() {
        isInfo = !isInfo
    }
}
