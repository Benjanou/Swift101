//
//  EmojiMemoryGame.swift
//  MemoryApp
//
//  Created by Gil Benjano on 15/04/2024.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let emojisLibrary: [String: [String]] = ["vehicles" : ["🚗","🚀","⛵️","🚕","🚂","🚁","🚑"],
                                                     "plants" : ["🌱","🌵","🌾","🍀","🌳","🌷"],
                                                     "clothes": ["🩲","🩳","👔","👖","🧦","🥾","👠","👗"],
                                                     "animals": ["🐶","🐵","🦁","🦊","🐰","🐹","🐭","🐱","🐻","🐼"],
                                                     "fruits": ["🍏","🍓","🍇","🍊","🍐","🍌","🍑","🍒","🍍","🫐"],
                                                     "flags": ["🏳️‍🌈","🇮🇱","🇵🇹","🇺🇸","🇿🇦","🇲🇦","🇷🇸"]
                                                    ]
    
    @Published private var model: MemoryGame<String>!
    
    private var selectedThemeName : String!
    
    init() {
        startNewGame()
    }
    
    func startNewGame(){
        let randomElement = EmojiMemoryGame.emojisLibrary.randomElement()!
        selectedThemeName = randomElement.key
        model = EmojiMemoryGame.createMemoryGame(with: selectedThemeName)
    }
    
    private static func createMemoryGame(with themeName: String) -> MemoryGame<String> {
        let emojis = emojisLibrary[themeName]!
        
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) {pairIndex in emojis[pairIndex]}
        
    }
    
    func shuffle(){
        model.shuffle()
    }
    
    func getTheme() -> String{
        return selectedThemeName
    }
    
    func getScore() -> String{
        return "\(model.score)"
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
        
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
