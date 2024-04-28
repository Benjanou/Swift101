//
//  EmojiMemoryGame.swift
//  MemoryApp
//
//  Created by Gil Benjano on 15/04/2024.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["🚗","🚀","⛵️","🚕","🚂","🚁","🚑"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairsOfCards: 14) {pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    @Published private var model = createMemoryGame()
    
    func shuffle(){
        model.shuffle()
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
        
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
