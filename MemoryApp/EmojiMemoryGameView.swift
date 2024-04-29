//
//  EmojiMemoryGameView.swift
//
//  Created by Gil Benjano on 24/03/2023.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
        
    @State var shouldReset = false
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Memorize!").font(.largeTitle)
                
                cards
                    .animation(.default, value: viewModel.cards)
                Button("Shuffle"){ viewModel.shuffle()}
            }.padding()
        }
    }

    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) {card in
                CardView(card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
            }
        }
        .foregroundColor(.orange)
    }
}



struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 20)
            Group {
                base.frame(minHeight: 100)
                base.fill(.white)
                base.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.system(size:200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
                .opacity(card.isFaceUp ? 1 : 0)
            base.fill(.green)
                .opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity((card.isFaceUp || !card.isMatched) ? 1 : 0)
    }
}



















struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(viewModel: game)
    }
}
