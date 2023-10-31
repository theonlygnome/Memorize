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
    
    enum Focused {
        case name
        case addEmojis
    }
    
    @FocusState private var focused: Focused?
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("Name", text: $theme.name)
                    .focused($focused, equals: .name)
            }
            Section(header: Text("Emojis")) {
                TextField("Add Emojis Here", text: $emojisToAdd)
                    .focused($focused, equals: .addEmojis)
                    .font(emojiFont)
                    .onChange(of: emojisToAdd) {
                        for emoji in emojisToAdd {
                            theme.emojis.append(String(emoji))
                        }
                    }
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
    
}

//#Preview {
//    ThemePalette()
//}
