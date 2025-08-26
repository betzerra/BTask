//
//  BGTaskApp.swift
//  BGTask
//
//  Created by Ezequiel Becerra on 26/08/2025.
//

import BackgroundTasks
import SwiftUI

@main
struct BGTaskApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .backgroundTask(.appRefresh("myapprefresh")) {
            Log.info("Background Task executed")
        }
    }
}
