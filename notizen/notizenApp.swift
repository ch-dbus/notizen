//
//  notizenApp.swift
//  notizen
//
//  Created by Dominik Bussinger on 16.07.2024.
//

import SwiftUI

@main
struct notizenApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Notiz.self)
        }
    }
}
