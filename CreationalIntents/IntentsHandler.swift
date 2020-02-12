//
//  CreationalIntentsHandler.swift
//  CreationalIntents
//
//  Created by Andres Rojas on 11/02/20.
//  Copyright © 2020 Andres Rojas. All rights reserved.
//

import UIKit
import Intents
import os

class IntentsHandler: NSObject, AddTaskIntentHandling {
    func resolveTask(for intent: AddTaskIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        guard let task = intent.task else {
            completion(INStringResolutionResult.needsValue())
            return
        }
        completion(INStringResolutionResult.success(with: task))
    }

    func handle(intent: AddTaskIntent, completion: @escaping (AddTaskIntentResponse) -> Void) {
        guard let task = intent.task else {
            completion(AddTaskIntentResponse(code: .failure, userActivity: nil))
            return
        }
        let newTask = Task(id: UUID(), title: task, isDone: false)
        let provider = DataProvider()
        provider.tasks.append(newTask)
        completion(AddTaskIntentResponse.success(task: task, amount: NSNumber(value: provider.tasks.count)))
    }
}
