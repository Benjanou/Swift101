//
//  EmojiMemoryGameView.swift
//
//  Created by Gil Benjano on 24/03/2023.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    //@State var emojis: [String] = ["🚗","🚀","⛵️","🚕","🚂","🚁","🚑"]
    @State var shouldReset = false
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Memorize!").font(.largeTitle)
                cards
                    .animation(.default, value: viewModel.cards)
                Button("Shuffle"){ viewModel.shuffle()}
                //            Spacer()
                //            HStack {
                //                Spacer()
                //                themeSelector(themeName: "Vehicles", symbol: "car")
                //                Spacer()
                //                themeSelector(themeName: "Winter", symbol: "snow")
                //                Spacer()
                //                themeSelector(themeName: "Technology", symbol: "apple.logo")
                //                Spacer()
                //            }
                
                
            }.padding()
        }
    }
    
//    func themeSelector(themeName: String, symbol: String) -> some View {
////        let vehicles: [String] =  ["🚗","🚀","⛵️","🚕","🚂","🚁","🚑"]
////        let winter: [String] = ["❄️","☃️","🧤","🏂","🎿","⛸️","🛷"]
////        let technology: [String] = ["💻","💾","📻","📺","📱","📡","📀"]
////
////        return VStack {
////            Text(themeName)
////            Button(action: {
////                switch themeName{
////                case "Vehicles":
////                    emojis = vehicles
////                case "Winter":
////                    emojis = winter
////                case "Technology":
////                    emojis = technology
////                default:
////                    emojis = vehicles
////                }
////            })
////            {Image(systemName: symbol)}
////        }
////        .foregroundColor(.blue)
//    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) {card in
                VStack {
                    CardView(card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                    Text(card.id)
                }
            }
        }
        .foregroundColor(.orange)
    }
}



struct CardView: View {
//    var content: String
//    @State var isFaceUp: Bool
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
            base.fill(.green).opacity(card.isFaceUp ? 0 : 1)

        }
//        .onTapGesture {
//            card.isFaceUp.toggle()
//        }
    }
    
//    var body: some View{
//        ZStack{
//            let shape = RoundedRectangle(cornerRadius: 20)
//            if isFaceUp {
//                shape.fill().foregroundColor(.white)
//                shape.strokeBorder(lineWidth: 3)
//                Text(content).font(.largeTitle)
//            }
//        }
//    }
}



















struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(viewModel: game)
    }
}
