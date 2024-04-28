//
//  MemorizeGame.swift
//  memoryApp
//
//  Created by Gil Benjano on 22/03/2024.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    func choose(_ card: Card){
        
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent){
        cards = Array<Card>()
        // add cards twice
        for pairIndex in 0..<max(2,numberOfPairsOfCards) {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
//        cards.shuffle()
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        let content: CardContent
        
        var id: String
    }
    
}
