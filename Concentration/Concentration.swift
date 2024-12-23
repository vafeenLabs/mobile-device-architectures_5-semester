//
//  Concentration.swift
//  Concentration
//
//  Created by nadya on 14.10.2023.
//

import Foundation

struct Concentration {
    
    private (set) var cards = [Card]()
    
    var score = 0
    
    private (set) var isHintUsed = false
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): choosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 1
                    cards[index].isGuessed = true
                    cards[matchIndex].isGuessed = true
                } else {
                    score -= 2
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    mutating func flipAllCardsFaceUp() {
        for index in cards.indices {
            if !cards[index].isMatched {
                cards[index].isFaceUp = true
            }
        }
    }
    
    mutating func flipAllCardsFaceDown() {
        for index in cards.indices {
            cards[index].isFaceUp = false
        }
    }
    
    mutating func shuffleCards() {
        cards.shuffle()
    }
    
    mutating func useHint() {
        isHintUsed = true
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): tou must at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
