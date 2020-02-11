//
//  CreationalIntentsHandler.swift
//  CreationalIntents
//
//  Created by Andres Rojas on 11/02/20.
//  Copyright © 2020 Andres Rojas. All rights reserved.
//

import UIKit
import Intents

class CreationalIntentsHandler: NSObject, AddTaskIntentHandling {
    func resolveTask(for intent: AddTaskIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        guard let task = intent.task else {
            completion(INStringResolutionResult.confirmationRequired(with: "Please enter your new task"))
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
        ListPresenter().saveTask(newTask)
        completion(AddTaskIntentResponse(code: .success, userActivity: nil))
    }

    func confirm(intent: AddTaskIntent, completion: @escaping (AddTaskIntentResponse) -> Void) {
        completion(AddTaskIntentResponse(code: .success, userActivity: nil))
    }


}
