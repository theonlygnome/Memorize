//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Naomi Anderson on 9/26/23.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
                                            
    private static var themeModel = ThemeModel(numberOfPairs: 11)
    private static var theme = themeModel.getTheme()
    
    private static func createMemoryGame() -> MemoryGame<String> {

        return MemoryGame(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
            if theme.emojis.indices.contains(pairIndex){
                return theme.emojis[pairIndex]
            } else {
                return "⁉️"
            }
            
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func newGame(numberOfPairs: Int) {
        EmojiMemoryGame.themeModel = ThemeModel(numberOfPairs: numberOfPairs)
        EmojiMemoryGame.theme = EmojiMemoryGame.themeModel.getTheme()
        model = EmojiMemoryGame.createMemoryGame()
    }
    
    // MARK: - Intents
    func getForegroundColor() -> Color {
        switch EmojiMemoryGame.theme.color {
        case "orange":
            return Color.orange
        case "red":
            return Color.red
        case "blue":
            return Color.blue
        case "purple":
            return Color.purple
        default:
            return Color.yellow
        }
    }
    
    func title() -> String {
        EmojiMemoryGame.theme.name
    }
    
    var score: Int {
        model.score
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}

