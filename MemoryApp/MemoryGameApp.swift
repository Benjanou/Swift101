//
//  MemoryAppApp.swift
//  MemoryApp
//
//  Created by Gil Benjano on 22/03/2024.
//

import SwiftUI

@main
struct MemoryGameApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
