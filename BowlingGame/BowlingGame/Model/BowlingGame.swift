//
//  BowlingGame.swift
//  BowlingGame
//

import Foundation

protocol BowlingGameProtocol: class {
    func rollAt(index: Int) -> Int?
}

class BowlingGame: BowlingGameProtocol {

    //MARK: - Internal properties

    var finalScore: Int {
        self.rounds.map{ $0.score }.reduce(0, +)
    }

    //MARK: - Private properties

    private var rounds = [Round]()
    private var deliveries = [Int]()

    //MARK: - Internal methods

    func normalRound(_ firstRoll: Int,_ secondRoll: Int) {
        self.rounds.append(NormalRound(firstRoll, secondRoll))
        self.deliveries.append(firstRoll)
        self.deliveries.append(secondRoll)
    }

    func spareRound(_ firstRoll: Int,_ secondRoll: Int) {
        self.rounds.append(SpareRound(firstRoll, secondRoll, self.deliveries.count, bowlingGame: self))
        self.deliveries.append(firstRoll)
        self.deliveries.append(secondRoll)
    }

    func strikeRound() {
        self.rounds.append(StrikeRound(self.deliveries.count, bowlingGame: self))
        self.deliveries.append(StrikeRound.strikeDefaultScore)
    }

    func bonusRound(_ firstRoll: Int,_ secondRoll: Int?) {
        self.rounds.append(BonusRound(firstRoll, secondRoll))
        self.deliveries.append(firstRoll)

        if let secondRoll = secondRoll {
            self.deliveries.append(secondRoll)
        }
    }

    func rollAt(index: Int) -> Int? {
        guard self.deliveries.indices.contains(index) else {
            return nil
        }
        return self.deliveries[index]
    }
}
