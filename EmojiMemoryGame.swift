//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Naomi Anderson on 9/26/23.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
                                            
    //private static var themeModel = ThemeModel(numberOfPairs: 11)
    private var theme: Theme
    
    @Published private var model: MemoryGame<String>
    
    init(theme: Theme) {
        self.theme = theme
        self.model = MemoryGame(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
            if theme.emojis.indices.contains(pairIndex){
                return theme.emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
            if theme.emojis.indices.contains(pairIndex){
                return theme.emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
        
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func newGame(numberOfPairs: Int) {
        model = createMemoryGame()
    }
    
    // MARK: - Intents
    func getForegroundColor() -> Color {
        Color(rgba: theme.color)
    }
    
    func title() -> String {
        theme.name
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

