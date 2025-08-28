//
//  AppModel.swift
//  BGTask
//
//  Created by Ezequiel Becerra on 27/08/2025.
//
import BackgroundTasks

@MainActor
class AppModel {
    func scheduleRefreshTask() {
        let request = BGAppRefreshTaskRequest(identifier: "myapprefresh")
        request.earliestBeginDate = Date().addingTimeInterval(60 * 5)

        do {
            try BGTaskScheduler.shared.submit(request)
            Log.info("Task scheduled")
        } catch {
            Log.info("Task schedule error: \(error)")
        }
    }
}
