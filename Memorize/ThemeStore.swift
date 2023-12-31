//
//  ThemeStore.swift
//  Memorize
//
//  Created by Naomi Anderson on 10/30/23.
//

import SwiftUI

extension UserDefaults {
    func themes(forKey key: String) -> [Theme] {
        if let jsonData = data(forKey: key),
           let decodedThemes = try? JSONDecoder().decode([Theme].self, from: jsonData) {
            return decodedThemes
        } else {
            return []
        }
    }
    
    func set(_ themes: [Theme], forKey key: String) {
        let data = try? JSONEncoder().encode(themes)
        set(data, forKey: key)
    }
}

class ThemeStore: ObservableObject, Identifiable {
    let name: String
    
    var id: String { name }
    
    private var userDefaultsKey: String { "ThemeName:" + name }
    
    var themes: [Theme] {
        get {
            UserDefaults.standard.themes(forKey: userDefaultsKey)
        }
        set {
            if !newValue.isEmpty {
                UserDefaults.standard.set(newValue, forKey: userDefaultsKey)
                objectWillChange.send()
            }
        }
    }
    
    
    static var builtins: [Theme] { [
        Theme(name: "Halloween", emojis: halloweenEmojis, numberOfPairs: 11, color: RGBA.init(color: Color.orange)),
        Theme(name: "Vehicles", emojis: vehicleEmojis, numberOfPairs: 16, color: RGBA.init(color: Color.red)),
        Theme(name: "Winter", emojis: winterEmojis, numberOfPairs: 12, color: RGBA.init(color: Color.blue))
    ]}
              
    init(named name: String) {
        self.name = name
        if themes.isEmpty {
            themes = ThemeStore.builtins
            if themes.isEmpty {
                themes = [Theme(name: "Warning", emojis: ["⚠️"], numberOfPairs: 2, color: RGBA.init(color: Color.yellow))]
            }
        }
    }
    
    @Published private var _cursorIndex = 0
    
    var cursorIndex: Int {
        get { boundsCheckedThemeIndex(_cursorIndex) }
        set { _cursorIndex = boundsCheckedThemeIndex(newValue) }
    }
    
    private func boundsCheckedThemeIndex(_ index: Int) -> Int {
        var index = index % themes.count
        if index < 0 {
            index += themes.count
        }
        return index
    }
    
    // MARK: - Adding Palettes
    
    // these functions are the recommended way to add Themes to the ThemeStore
    // since they try to avoid duplication of Identifiable-ly identical Themes
    // by first removing/replacing any Theme with the same id that is already in palettes
    // it does not "remedy" existing duplication, it just does not "cause" new duplication
    
    func insert(_ theme: Theme, at insertionIndex: Int? = nil) { // "at" default is cursorIndex
        let insertionIndex = boundsCheckedThemeIndex(insertionIndex ?? cursorIndex)
        if let index = themes.firstIndex(where: { $0.id == theme.id }) {
            themes.move(fromOffsets: IndexSet([index]), toOffset: insertionIndex)
            themes.replaceSubrange(insertionIndex...insertionIndex, with: [theme])
        } else {
            themes.insert(theme, at: insertionIndex)
        }
    }
    
    func insert(name: String, emojis: [String], numberofPairs: Int, color: RGBA, at index: Int? = nil) {
        insert(Theme(name: name, emojis: emojis, numberOfPairs: numberofPairs, color: color), at: index)
    }
    
    func append(_ theme: Theme) { // at end of themes
        if let index = themes.firstIndex(where: { $0.id == theme.id }) {
            if themes.count == 1 {
                themes = [theme]
            } else {
                themes.remove(at: index)
                themes.append(theme)
            }
        } else {
            themes.append(theme)
        }
    }
    
    func append(name: String, emojis: [String], numberOfPairs: Int, color: RGBA) {
        append(Theme(name: name, emojis: emojis, numberOfPairs: numberOfPairs, color: color))
    }
}

extension ThemeStore: Hashable {
    static func == (lhs: ThemeStore, rhs: ThemeStore) -> Bool {
        lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
}

struct RGBA: Codable, Equatable, Hashable {
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double
}

extension Color {
   init(rgba: RGBA) {
      self.init(.sRGB, red: rgba.red, green: rgba.green, blue: rgba.blue, opacity: rgba.alpha)
   }
}

extension RGBA {
   init(color: Color) {
      var red: CGFloat = 0
      var green: CGFloat = 0
      var blue: CGFloat = 0
      var alpha: CGFloat = 0
      UIColor(color).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
      self.init(red: Double(red), green: Double(green), blue: Double(blue), alpha: Double(alpha))
} }
