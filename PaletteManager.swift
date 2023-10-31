//
//  PaletteManager.swift
//  Memorize
//
//  Created by Naomi Anderson on 10/30/23.
//

import SwiftUI

struct PaletteManager: View {
    let stores: [ThemeStore]
    @State private var selectedStore: ThemeStore?
    
    var body: some View {
        NavigationSplitView {
            List(stores, selection: $selectedStore) { store in
                Text(store.name)
                    .tag(store)
            }
        } content: {
            if let selectedStore {
               // EditableThemeList(store: store)
            }
        } detail: {
            Text("Choose a palette")
        }
    }
}

//#Preview {
//    PaletteManager()
//}
