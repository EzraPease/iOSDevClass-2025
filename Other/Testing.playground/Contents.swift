import UIKit


enum Move {
    case rock, paper, scissors
}

enum Outcome {
    case tie, player1Wins, player2Wins
}

func playersInput(player1: Move, player2: Move) -> Outcome {
    guard player1 != player2 else { return .tie }
    switch player1 {
    case .rock:
        switch player2 {
        case .paper:
            return .player2Wins
        case .scissors:
            return .player1Wins
        }
    case .paper:
        switch player2 {
        case .rock:
            return .player1Wins
        case .scissors:
            return .player2Wins
        }
    case .scissors:
        switch player2 {
        case .rock:
            return .player2Wins
        case .paper:
            return .player1Wins
        }
    }
}
    
    
    print(playersInput(player1: .rock, player2: .scissors))
    
    
    
    
    
    
    
    
