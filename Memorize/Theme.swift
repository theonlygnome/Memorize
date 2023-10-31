//
//  Theme.swift
//  Memorize
//
//  Created by Naomi Anderson on 9/30/23.
//

import Foundation

let halloweenEmojis =
    ["👻", "🎃", "🕷️", "😈", "💀","🧙‍♀️","👹","🐱","😱","🍭", "🍬"]
let halloweenColor = "orange"

let vehicleEmojis = ["🚗","🚕","🚓","🚜","🛻","🚒","🚑","🚚","✈️","🚀","🚌","🚲","⛵️","🏍️","🛵","🚂"]
let vehicleColor = "red"

let winterEmojis = ["🥶","❄️","☃️","🧤","🧣","🏂","🧦","🛷","🥌","🌨️","⛷️","⛸️"]
let winterColor = "blue"

struct Theme: Identifiable, Codable, Hashable {
    var name: String
    var emojis: [String]
    var numberOfPairs: Int
    var color: RGBA
    var id = UUID()
}


//struct ThemeModel {
//    var themeArray = [Theme]()
//    var numberOfPairs: Int
//    
//    init(numberOfPairs: Int) {
//        self.numberOfPairs = numberOfPairs
//        themeArray = [halloweenCardTheme, vehicleCardTheme, winterCardTheme]
//    }
//    
//    func getTheme() -> Theme {
//        let index = Int.random(in: 0...2)
//        return themeArray[index];
//    }
//    
//    func cardThemeCreator(title: String, emojis: [String], color: RGBA) -> Theme {
//        let newArray = emojis.shuffled()
//        let subNewArray = newArray[..<numberOfPairs]
//        return Theme(name: title, emojis: Array(subNewArray)+Array(subNewArray), numberOfPairs: numberOfPairs, color: color)
//    }
//    
//    var halloweenCardTheme: Theme {
//        cardThemeCreator(title: "Halloween", emojis: halloweenEmojis, color: halloweenColor)
//    }
//    
//    var vehicleCardTheme: Theme {
//        cardThemeCreator(title: "Vehicles", emojis: vehicleEmojis, color: vehicleColor)
//    }
//    
//    var winterCardTheme: Theme {
//        cardThemeCreator(title: "Winter", emojis: winterEmojis,  color: winterColor)
//    }
//}
