//
//  HomeViewController.swift
//  OA_tris
//
//  Created by Davide Montagna on 21/10/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var playButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    @IBOutlet var gameStateLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    
    /// First row
    @IBOutlet var position00View: UIView!
    @IBOutlet var position00Button: UIButton!
    @IBOutlet var position00Label: UILabel!
    
    @IBOutlet var position01View: UIView!
    @IBOutlet var position01Button: UIButton!
    @IBOutlet var position01Label: UILabel!
    
    @IBOutlet var position02View: UIView!
    @IBOutlet var position02Button: UIButton!
    @IBOutlet var position02Label: UILabel!
    
    /// Second row
    @IBOutlet var position10View: UIView!
    @IBOutlet var position10Button: UIButton!
    @IBOutlet var position10Label: UILabel!
    
    @IBOutlet var position11View: UIView!
    @IBOutlet var position11Button: UIButton!
    @IBOutlet var position11Label: UILabel!
    
    @IBOutlet var position12View: UIView!
    @IBOutlet var position12Button: UIButton!
    @IBOutlet var position12Label: UILabel!
    
    /// Third row
    @IBOutlet var position20View: UIView!
    @IBOutlet var position20Button: UIButton!
    @IBOutlet var position20Label: UILabel!
    
    @IBOutlet var position21View: UIView!
    @IBOutlet var position21Button: UIButton!
    @IBOutlet var position21Label: UILabel!
    
    @IBOutlet var position22View: UIView!
    @IBOutlet var position22Button: UIButton!
    @IBOutlet var position22Label: UILabel!
    
    // MARK: - ViewModel
    
    lazy var viewModel = HomeViewModel(delegate: self)
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameStateLabel.text = "E' il turno del giocatore: O"
    }
    
    // MARK: - Actions
    
    @IBAction func playButtonTapped(_ sender: Any) {
        resetCell(cellLabel: position00Label, cellButton: position00Button)
        resetCell(cellLabel: position01Label, cellButton: position01Button)
        resetCell(cellLabel: position02Label, cellButton: position02Button)
        resetCell(cellLabel: position10Label, cellButton: position10Button)
        resetCell(cellLabel: position11Label, cellButton: position11Button)
        resetCell(cellLabel: position12Label, cellButton: position12Button)
        resetCell(cellLabel: position20Label, cellButton: position20Button)
        resetCell(cellLabel: position21Label, cellButton: position21Button)
        resetCell(cellLabel: position22Label, cellButton: position22Button)
        viewModel.playAgain()
        showScore()
        gameStateLabel.text = "E' il turno del giocatore: O"
        playButton.isHidden = true
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        resetCell(cellLabel: position00Label, cellButton: position00Button)
        resetCell(cellLabel: position01Label, cellButton: position01Button)
        resetCell(cellLabel: position02Label, cellButton: position02Button)
        resetCell(cellLabel: position10Label, cellButton: position10Button)
        resetCell(cellLabel: position11Label, cellButton: position11Button)
        resetCell(cellLabel: position12Label, cellButton: position12Button)
        resetCell(cellLabel: position20Label, cellButton: position20Button)
        resetCell(cellLabel: position21Label, cellButton: position21Button)
        resetCell(cellLabel: position22Label, cellButton: position22Button)
        viewModel.reset()
        gameStateLabel.text = "E' il turno del giocatore: O"
        scoreLabel.isHidden = true
        playButton.isHidden = true
    }

    @IBAction func cellInGridTapped(sender: UIButton) {
      
        switch sender.tag {
        case 1:
            viewModel.fillMatrixPositions(row: 0, column: 0)
        case 2:
            viewModel.fillMatrixPositions(row: 0, column: 1)
        case 3:
            viewModel.fillMatrixPositions(row: 0, column: 2)
        case 4:
            viewModel.fillMatrixPositions(row: 1, column: 0)
        case 5:
            viewModel.fillMatrixPositions(row: 1, column: 1)
        case 6:
            viewModel.fillMatrixPositions(row: 1, column: 2)
        case 7:
            viewModel.fillMatrixPositions(row: 2, column: 0)
        case 8:
            viewModel.fillMatrixPositions(row: 2, column: 1)
        case 9:
            viewModel.fillMatrixPositions(row: 2, column: 2)
        default:
            return
        }
    }

    // MARK: - Private methods
    
    private func setChosenCell(positionLabel: String, positionButton: String) {
        if let inGridPositionLabel = value(forKey: positionLabel) as? UILabel {
            inGridPositionLabel.text = viewModel.playerIcon
            inGridPositionLabel.textColor = viewModel.iconColor
            inGridPositionLabel.isHidden = false
        }
        if let inGridPositionButton = value(forKey: positionButton) as? UIButton {
            inGridPositionButton.isHidden = true
        }
    }
    
    private func disableCellsButton() {
        position00Button.isEnabled = false
        position01Button.isEnabled = false
        position02Button.isEnabled = false
        position10Button.isEnabled = false
        position11Button.isEnabled = false
        position12Button.isEnabled = false
        position20Button.isEnabled = false
        position21Button.isEnabled = false
        position22Button.isEnabled = false
    }
    
    private func resetCell(cellLabel: UILabel, cellButton: UIButton) {
        cellLabel.isHidden = true
        cellButton.isEnabled = true
        cellButton.isHidden = false
    }
    
    private func showScore() {
        scoreLabel.text = "O = \(viewModel.playerOScore)  ||  X = \(viewModel.playerXScore)"
        scoreLabel.isHidden = false
    }
}

// MARK: - Extensions

extension HomeViewController: HomeViewModelDelegate {
    func refreshGrid(row: Int, column: Int) {
        setChosenCell(positionLabel: "position\(row)\(column)Label", positionButton: "position\(row)\(column)Button")
    }
    
    func changePlayer() {
        gameStateLabel.text = "E' il turno del giocatore: \(viewModel.playerIcon)"
    }
    
    func showResult(result: HomeViewModelUseCases) {
        switch result {
        case .winner:
            gameStateLabel.text = "Il vincitore è il giocatore: \(viewModel.result)"
            disableCellsButton()
            viewModel.increaseScore()
            playButton.isHidden = false
        case .draw:
            gameStateLabel.text = "\(viewModel.result)!"
            disableCellsButton()
            playButton.isHidden = false
        }
    }
}
