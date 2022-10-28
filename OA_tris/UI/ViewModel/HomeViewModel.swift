//
//  HomeViewModel.swift
//  OA_tris
//
//  Created by Davide Montagna on 21/10/22.
//

import Foundation
import UIKit

protocol HomeViewModelDelegate: AnyObject {
    func showResult(result: HomeViewModelUseCases)
    func changePlayer()
    func refreshGrid(row: Int, column: Int)
}

class HomeViewModel: NSObject {
    
    // MARK: - Delegate
    
    weak var delegate: HomeViewModelDelegate?
    
    // MARK: - Properties
    
    var playerActive = 3
    var matrix = [[00, 01, 02], [10, 11, 12], [20, 21, 22]]
    var playerIcon = "O"
    var iconColor = UIColor(ciColor: .blue)
    var result = ""
    var gameHasEnded = false
    var playerXScore = 0
    var playerOScore = 0
    var counter = 0
    
    // MARK: - Init
    
    init(delegate: HomeViewModelDelegate) {
        super.init()
        self.delegate = delegate
    }
    
    // MARK: - Public methods
    
    func fillMatrixPositions(row: Int, column: Int) {
        matrix[row][column] = playerActive
        counter += 1
        if counter >= 5 {
            checkResult()
        }
        if matrix[row][column] == 3 || matrix[row][column] == 4 {
            delegate?.refreshGrid(row: row, column: column)
        }
        changePlayerActive()
        print(matrix)
        print(counter)
    }
    
    func changePlayerActive() {
        if playerActive == 3 {
            playerIcon = "X"
            playerActive = 4
            iconColor = UIColor(ciColor: .red)
        } else {            
            playerIcon = "O"
            playerActive = 3
            iconColor = UIColor(ciColor: .blue)
        }
        if result == "" {
            delegate?.changePlayer()
        }
        print(playerActive)
    }
    
    func increaseScore() {
        if result == "X" {
            playerXScore += 1
        }
        if result == "O" {
            playerOScore += 1
        }
    }
    
    func playAgain() {
        playerActive = 3
        playerIcon = "O"
        matrix = [[00, 01, 02], [10, 11, 12], [20, 21, 22]]
        counter = 0
        result = ""
        gameHasEnded = false
    }
    
    func reset() {
        playerActive = 3
        playerIcon = "O"
        matrix = [[00, 01, 02], [10, 11, 12], [20, 21, 22]]
        playerXScore = 0
        playerOScore = 0
        counter = 0
        result = ""
        gameHasEnded = false
    }
    
    // MARK: - Private methods

    private func checkResult() {
        
        for index in 0...matrix.count - 1 {
            gameHasEnded = checkRow(row: index)
            if gameHasEnded != false {
                result = playerIcon
                break
            }
            gameHasEnded = checkColumn(column: index)
            if gameHasEnded != false {
                result = playerIcon
                break
            }
        }
        gameHasEnded = checkDiagonal()
        if gameHasEnded != false {
            result = playerIcon
        }
        
        showResult()
    }
    
    private func showResult() {
        if result != "" {
            delegate?.showResult(result: .winner)
        }
        if counter == 9 && result == "" {
            result = "PAREGGIO"
            delegate?.showResult(result: .draw)
        }
    }
    
    private func checkRow(row: Int) -> Bool {
        return matrix[row][0] == playerActive && matrix[row][1] == playerActive && matrix[row][2] == playerActive
    }
    
    private func checkColumn(column: Int) -> Bool {
        return matrix[0][column] == playerActive && matrix[1][column] == playerActive && matrix[2][column] == playerActive
    }
    
    private func checkDiagonal() -> Bool {
        return (matrix[0][0] == playerActive && matrix[1][1] == playerActive && matrix[2][2] == playerActive) ||
               (matrix[0][2] == playerActive && matrix[1][1] == playerActive && matrix[2][0] == playerActive)
    }
}
