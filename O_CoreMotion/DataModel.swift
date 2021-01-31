//
//  Model.swift
//  O_CoreMotion
//
//  Created by olivier robin on 30/01/2021.
//

import Foundation


class DataModel: ObservableObject {
    
    var coreMotion: CoreMotionHelper? = nil
    
    init() {
        coreMotion = CoreMotionHelper()
    }
    
    func startMotionManager() {
        coreMotion?.startMotionManager()
    }
    
    func getMotionResult(completion:@escaping (_ error: Error?, _ motionResult: MotionResult ) -> Void) {
        coreMotion?.getMotionResult(completion: { (error, motionResult) in
            completion(error, motionResult)
        })
    }
    
    // request activity status from CoreMotion layer
    
    func getActivityResult(completion:@escaping (_ error: Error?, _ activityStatus: ActivityResult ) -> Void) {
        coreMotion?.getActivityResult(completion: { (error, activityResult) in
            
            completion(error, activityResult)
        })

    }

    
    // request pedometer value from CoreMotion layer

    func getPedometerResult(completion:@escaping (_ error: Error?, _ pedometerResult: PedometerResult? ) -> Void) {
        coreMotion?.getPedometerResult(completion: { (error, pedometerResult) in

            completion(error, pedometerResult)
        })

    }
    
}

