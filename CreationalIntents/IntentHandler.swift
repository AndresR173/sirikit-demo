//
//  IntentHandler.swift
//  CreationalIntents
//
//  Created by Andres Rojas on 11/02/20.
//  Copyright © 2020 Andres Rojas. All rights reserved.
//

import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        return IntentsHandler()
    }
    
}
