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
    
    @IBOutlet weak var scoreLabel: UILabel!
    
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
        scoreLabel.text = "Score= \(game.score)"
    }
    
    func emoji(for card:Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
        
    @IBAction func newGame(_ sender: UIButton) {
        flipCount = 0
        game.score = 0
        for card in cardButtons.indices {
            game.cards[card].isFaceUp = false
            game.cards[card].isMatched = false
        }
        game.indexOfOneAndOnlyFaceUpCard = nil
        game.cards.shuffle()
        updateViewFromModel()
    }
    
    @IBAction func shuffle(_ sender: UIButton) {
        for card in self.cardButtons.indices {
            self.game.cards[card].isFaceUp = false
        }
        game.cards.shuffle()
        updateViewFromModel()
    }
    
    func delay(_ delay: Double, closure:@escaping ()->()){
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when,execute: closure)
    }
    @IBAction func help(_ sender: UIButton) {
        for card in cardButtons.indices {
            if game.cards[card].isMatched == false {
                game.cards[card].isFaceUp = true
            }
        }
        updateViewFromModel()
        delay(1){
            for card in self.cardButtons.indices{
                if self.game.cards[card].isMatched == false{
                    self.game.cards[card].isFaceUp = false
                }
            }
            self.updateViewFromModel()
        }
    }
}
