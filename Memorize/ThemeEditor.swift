//
//  ThemePalette.swift
//  Memorize
//
//  Created by Naomi Anderson on 10/30/23.
//

import SwiftUI

struct ThemeEditor: View {
    @Binding var theme: Theme
    
    private let emojiFont = Font.system(size: 40)
    
    @State private var emojisToAdd: String = ""
    @State private var themeColor = Color.blue
    @State private var stepperValue = 2
    
    enum Focused {
        case name
        case addEmojis
        case colorPicker
        case pairNumbers
    }
    
    @FocusState private var focused: Focused?
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("Name", text: $theme.name)
                    .focused($focused, equals: .name)
            }
            Section(header: Text("Color")) {
                colorPicker
            }
            Section(header: Text("Number of Pairs")) {
               stepper
            }
            Section(header: Text("Emojis")) {
                addEmojis
                removeEmojis
            }
        }
        .onAppear {
            if theme.name.isEmpty {
                focused = .name
            } else {
                focused = .addEmojis
            }
        }
    }
    
     var removeEmojis: some View {
         VStack(alignment: .trailing) {
             Text("Tap to Remove Emojis").font(.caption).foregroundColor(.gray)
             LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                 ForEach(theme.emojis, id: \.self) { emoji in
                     Text(emoji)
                         .onTapGesture {
                             withAnimation {
                                 if let index = theme.emojis.firstIndex(of: emoji) {
                                     theme.emojis.remove(at: index)
                                     emojisToAdd.remove(emoji.first!)
                                 }
                             }
                         }
                 }
             }
         }
         .font(emojiFont)
     }
    
    var stepper: some View {
        Stepper {
                Text("Number of pairs: \(stepperValue)")
                } onIncrement: {
                    stepperValue += 1
                    if stepperValue >= theme.emojis.count { stepperValue = theme.emojis.count }
                    theme.numberOfPairs = stepperValue
                } onDecrement: {
                    stepperValue -= 1
                    if stepperValue <= 2 { stepperValue = 2 }
                    theme.numberOfPairs = stepperValue
                }
    }
    
    var colorPicker: some View {
        ColorPicker("Theme Color", selection: $themeColor)
            .onChange(of: themeColor) {
                theme.color = RGBA(color: themeColor)
            }
    }
    
    var addEmojis: some View {
        TextField("Add Emojis Here", text: $emojisToAdd)
            .focused($focused, equals: .addEmojis)
            .font(emojiFont)
            .onChange(of: emojisToAdd) {
                for emoji in emojisToAdd {
                    if emoji.isEmoji && !theme.emojis.contains(String(emoji)) {
                        theme.emojis.append(String(emoji))
                    }
                }
            }
    }
}
