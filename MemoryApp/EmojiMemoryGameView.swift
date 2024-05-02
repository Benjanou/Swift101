//
//  EmojiMemoryGameView.swift
//
//  Created by Gil Benjano on 24/03/2023.
//

import SwiftUI
let themeColor = Color(red: 0.5, green: 0.3, blue: 0.5)

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    @State var shouldReset = false
    
    var body: some View {
        
            VStack {
                HStack {
                    Spacer()
                    VStack {
                        Text("Memorize!")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                        Text("Theme: " + viewModel.getTheme())
                            .foregroundColor(.white)
                            .bold()
                    }
                    Spacer()
                    Text("score: " + viewModel.getScore())
                            .font(.title3)
                            .foregroundColor(.white)
                }
                ZStack {
                    let base = RoundedRectangle(cornerRadius: 20)
                    base.frame(minHeight: 100)
                    base.fill(Color(red: 0.9, green: 0.7, blue: 0.9))
                    base.strokeBorder(lineWidth: 3)
                    base.fill(themeColor)
                        .opacity(0)
                    
                    ScrollView {
                        cards
                            .animation(.default, value: viewModel.cards)
                    }
                    .padding(.bottom, 3)
                    .padding(.top, 3)
                    .clipShape(RoundedRectangle(cornerRadius: 29))
                    
                }
                
                Button(action:{ viewModel.startNewGame()}){
                    Text("New Game")
                        .foregroundColor(.white)
                        .padding(5)
                }
                .background(themeColor)
                .cornerRadius(6)
            }.padding()
            .background(themeColor.brightness(-0.3).edgesIgnoringSafeArea(.all))
    }
    

    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) {card in
                if !(card.isMatched && !card.isFaceUp) {
                    CardView(card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
        .foregroundColor(themeColor)
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
            base.fill(themeColor)
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
