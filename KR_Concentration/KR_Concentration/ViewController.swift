//
//  ViewController.swift
//  KR_Concentration
//
//  Created by xcode on 01.03.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var flipsCo
    var flipCount = 0 {
        didSet{
            flipsCountLabel.text = "Flips: \(flipCount)"
        }
    }
    func touchCard( sender:UIButton){
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        }
    }
    func flipCard(withEmoji emoji: String, on button:UIButton){
        if button.currentTitle == emoji {
            button.setTitle("",for : UIControl.State.normal)
            button.backgroundColor =
        } else {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor =
        }
    }
}

