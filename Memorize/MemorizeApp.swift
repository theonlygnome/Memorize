//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Naomi Anderson on 9/18/23.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var themeStore = ThemeStore(named: "Main")
    
    var body: some Scene {
        WindowGroup {
           EditableThemeList()
                .environmentObject(themeStore)
        }
    }
}
