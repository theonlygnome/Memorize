//
//  ThemeList.swift
//  Memorize
//
//  Created by Naomi Anderson on 10/30/23.
//

import SwiftUI

struct EditableThemeList: View {
    @EnvironmentObject var store: ThemeStore
    @State private var showCursorTheme = false
    @State private var showTheme = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach (store.themes) { theme in
                    NavigationLink(value: theme) {
                        VStack(alignment: .leading) {
                            Text(theme.name)
                            // Text(theme.color)
                            // Text("\(theme.numberOfPairs) pairs")
                            Text(theme.emojis.joined(separator: " ")).lineLimit(1)
                        }
                        .swipeActions(edge: .trailing) {
                            Button {
                                showTheme = true
                                if let index = store.themes.firstIndex(where: {$0.id == theme.id}) {
                                    store.cursorIndex = index
                                }
                            }
                            label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            Button(role: .destructive) {
                                print("Deleting Theme")
                                if let index = store.themes.firstIndex(where: {$0.id == theme.id}) {
                                    store.themes.remove(at: index)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                        }
                    }
                }
                .onMove { indexSet, newOffset in
                    store.themes.move(fromOffsets: indexSet, toOffset: newOffset)
                    
                }
            }
            .navigationDestination(isPresented: $showTheme) {
                ThemeEditor(theme: $store.themes[store.cursorIndex])
            }
            .navigationDestination(for: Theme.self) { theme in
                EmojiMemoryGameView(viewModel: EmojiMemoryGame(theme: theme))
            }
            .navigationDestination(isPresented: $showCursorTheme) {
                ThemeEditor(theme: $store.themes[store.cursorIndex])
            }            .navigationTitle("\(store.name) Themes")
            .toolbar {
                Button {
                    store.insert(Theme(name: "", emojis: [], numberOfPairs: 2, color: RGBA(color: Color.blue)))
                    showCursorTheme = true
                } label: {
                    Image(systemName: "plus")
                }
            }
                
        }
    }
}

struct ThemeList: View {
    @EnvironmentObject var store: ThemeStore
    
    var body: some View {
        NavigationStack {
            List(store.themes) { theme in
                NavigationLink(value: theme) {
                    Text(theme.name)
                }
            }
            .navigationDestination(for: Theme.self) { theme in
                ThemeView(theme: theme)
            }
            .navigationTitle("\(store.name) Themes")
            
        }
    }
}

struct ThemeView: View {
    let theme: Theme
    
    var body: some View {
        VStack {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(theme.emojis, id: \.self) { emoji in
                    NavigationLink(value: emoji) {
                        Text(emoji)
                    }
                }
            }
            .navigationDestination(for: String.self) { emoji in
                Text(emoji).font(.system(size: 300))
            }
            Spacer()
        }
        .padding()
        .font(.largeTitle)
        .navigationTitle(theme.name)
    }
}


#Preview {
    ThemeList()
}
