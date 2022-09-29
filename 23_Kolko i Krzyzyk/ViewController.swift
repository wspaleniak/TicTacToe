//
//  ViewController.swift
//  23_Kolko i Krzyzyk
//
//  Created by Wojciech Spaleniak on 20/09/2022.
//

import UIKit

class ViewController: UIViewController {
    
    // 1->Kółko 2->Krzyżyk
    var activePlayer = 1
    
    // 0-Pusty 1-Kółko 2-Krzyżyk
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    let winningCombinations = [
        [0,1,2], [3,4,5], [6,7,8],
        [0,3,6], [1,4,7], [2,5,8],
        [0,4,8], [2,4,6]
    ]
    
    var activeGame = true
    
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var playAgain: UIButton!
    @IBAction func playAgain(_ sender: Any) {
        
        // ZEROWANIE PLANSZY
        activePlayer = 1
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        activeGame = true
        
        // ZEROWANIE GRAFICZNE PLANSZY
        for i in 1..<10 {
            if let button = view.viewWithTag(i) as? UIButton {
                button.setBackgroundImage(nil, for: [])
            }
        }
        
        // UKRYCIE EKRANU Z WYGRANYM I PRZYCISKU
        UIView.animate(withDuration: 1) {
            self.winnerLabel.center = CGPoint(x: self.winnerLabel.center.x - 500, y: self.winnerLabel.center.y)
            self.playAgain.center = CGPoint(x: self.playAgain.center.x - 500, y: self.playAgain.center.y)
        }
    }
    
    @IBAction func buttonPressed(_ sender: AnyObject) {
        
        let activePosition = sender.tag - 1
        
        if gameState[activePosition] == 0 && activeGame {
            
            gameState[activePosition] = activePlayer
            
            if activePlayer == 1 {
                sender.setBackgroundImage(UIImage(named: "nought.png"), for: [])
                activePlayer = 2
            } else if activePlayer == 2 {
                sender.setBackgroundImage(UIImage(named: "cross.png"), for: [])
                activePlayer = 1
            }
        }
        
        for combination in winningCombinations {
            if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]] {
                
                activeGame = false
                
                let winner = gameState[combination[0]]
                
                if winner == 1 {
                    winnerLabel.text = "Kółko wygrało!"
                } else if winner == 2 {
                    winnerLabel.text = "Krzyżyk wygrał!"
                }
                
                // POJAWIENIE SIĘ EKRANU Z WYGRANYM I PRZYCISKU
                UIView.animate(withDuration: 1) {
                    self.winnerLabel.center = CGPoint(x: self.winnerLabel.center.x + 500, y: self.winnerLabel.center.y)
                    self.playAgain.center = CGPoint(x: self.playAgain.center.x + 500, y: self.playAgain.center.y)
                }
            }
        }
        
        // MOJA WŁASNA FUNKCJONALNOŚĆ
        let filtered = gameState.filter { $0 == 0 }
        if filtered.count == 0 {
            winnerLabel.text = "Remis..."
            
            UIView.animate(withDuration: 1) {
                self.winnerLabel.center = CGPoint(x: self.winnerLabel.center.x + 500, y: self.winnerLabel.center.y)
                self.playAgain.center = CGPoint(x: self.playAgain.center.x + 500, y: self.playAgain.center.y)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UKRYCIE EKRANU Z WYGRANYM I PRZYCISKU
        winnerLabel.center = CGPoint(x: winnerLabel.center.x - 500, y: winnerLabel.center.y)
        playAgain.center = CGPoint(x: playAgain.center.x - 500, y: playAgain.center.y)
    }

}
