//
//  ContentView.swift
//  BGTask
//
//  Created by Ezequiel Becerra on 26/08/2025.
//

import BackgroundTasks
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button {
                scheduleTask()
            } label: {
                Text("Schedule Task")
            }
        }
        .padding()
    }

    func scheduleTask() {
        Log.info("Button pressed")
        let request = BGAppRefreshTaskRequest(identifier: "myapprefresh")

        do {
            try BGTaskScheduler.shared.submit(request)
            Log.info("Task scheduled")
        } catch {
            Log.info("Task schedule error: \(error)")
        }
    }
}

#Preview {
    ContentView()
}
