//
//  AnalyticsManager.swift
//  Sculpt
//
//  Created by Scott Colas on 3/28/21.
//

import Foundation
import FirebaseAnalytics
final class AnalyticsManager{
    static let shared = AnalyticsManager()
    
    private init() {}
    
    func logEvents(){
        Analytics.logEvent("", parameters: [:])
    }
}
