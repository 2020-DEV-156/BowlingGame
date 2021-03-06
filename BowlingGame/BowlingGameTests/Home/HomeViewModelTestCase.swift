//
//  HomeViewModelTestCase.swift
//  BowlingGameTests
//

import XCTest
@testable import BowlingGame

class HomeViewModelTestCase: XCTestCase {

    var sut: HomeViewModel!
    var allowedScores: [Int]!
    var mockBowlingGame: BowlingGameProtocol!

    override func setUp() {
        self.allowedScores = [0,1,2,3,4,5,6,7,8,9,10]
        self.mockBowlingGame = MockBowlingGame()
        self.sut = HomeViewModel(allowedScores: self.allowedScores, bowlingGame: self.mockBowlingGame)
    }

    override func tearDown() {
        self.sut = nil
        self.allowedScores = nil
        self.mockBowlingGame = nil
    }

    func test_shouldProvideValidFinalScore() {
        //Arrange

        //Act
        let finalScore = try! self.sut.getFinalScore()

        //Assert
        XCTAssertEqual(finalScore, "0")
    }

    func test_rollsSequenceString_shouldReturnCommaSeparatedString() {
        //Arrange

        //Act
        self.sut.rolls = [1,2,3]
        let rollsSequenceString = self.sut.rollsSequenceString

        //Assert
        XCTAssertEqual(rollsSequenceString, "1, 2, 3", "Score sequence should have matched.")
    }

    func test_whenResetGameCalled_shouldRemovePreviousGameData() {
        //Arrange
        self.sut.rolls = [1,2,3]

        //Act
        self.sut.resetGame()

        //Assert
        XCTAssertTrue(self.sut.rolls.isEmpty, "Previous game rolls should have been deleted.")

    }

}
