//
//  ViewController.swift
//  Concentration_KKR
//
//  Created by xcode on 15.03.2024.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount = 0{
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    var emojiChoices = ["💎","💿","💶","💵","💷","💴","💳","💰"]
    
    var emoji = [Int:String]()
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("choosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            }
    }
    
    func emoji(for card: Card) -> String {
        return emoji[card.identifier] ?? "?"
    }
    
    func newGame(_sender: UIButton) {
        flipCount = 0
        for card in cardButtons {
            card.setTitle("", for: UIControl.State.normal)
            card.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
    }
    
        
        
    //func flipCard(withEmoji emoji: String, on button: UIButton){
    //    if button.currentTitle == emoji{
    //        button.setTitle("", for: UIControl.State.normal)
    //        button.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    //    } else {
   //         button.setTitle(emoji, for: UIControl.State.normal)
    //        button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
      //  }
   // }
    
}

}
