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
    @Environment(\.scenePhase) private var phase
    let appModel = AppModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: phase, { _, newValue in
            if newValue == .background {
                appModel.scheduleRefreshTask()
            }
        })
        .backgroundTask(.appRefresh("myapprefresh")) {
            Log.info("Background Task executed")

            await appModel.scheduleRefreshTask()
        }
    }
}
