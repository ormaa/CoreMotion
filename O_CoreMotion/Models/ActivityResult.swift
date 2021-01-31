//
//  ActivityResult.swift
//  O_CoreMotion
//
//  Created by olivier robin on 30/01/2021.
//

import Foundation


enum ActivityStatus {
    case unknown
    case walking
    case running
    case cycling
    case automotive
}

class ActivityResult {
    var activityStatus: ActivityStatus = .unknown
    
    init(status: ActivityStatus) {
        self.activityStatus = status
    }
}
