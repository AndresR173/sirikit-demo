//
//  ActivityHelper.swift
//  SiriKitDemo
//
//  Created by Andres Rojas on 11/02/20.
//  Copyright © 2020 Andres Rojas. All rights reserved.
//

import Foundation
import Intents
import CoreSpotlight
import MobileCoreServices

class ActivityHelper {
    static func getNewTaskActivity() -> NSUserActivity {
        let activity = NSUserActivity(activityType: Constants.kNewTaskActivityType)
        activity.title = "Add new task"
        activity.isEligibleForSearch = true
        activity.isEligibleForPrediction = true
        activity.suggestedInvocationPhrase = "New task"

        let attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeItem as String)
        attributes.contentDescription = "Let's add more tasks to do"
        activity.contentAttributeSet = attributes

        return activity
    }
}
