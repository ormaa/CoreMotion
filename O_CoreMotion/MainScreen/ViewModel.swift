//
//  ViewModel.swift
//  O_CoreMotion
//
//  Created by olivier robin on 30/01/2021.
//

import SwiftUI
import Combine

class ViewModel: ObservableObject {
    
     
    var dataModel:DataModel
    
    @Published var activityStatusText: String = "?"
    @Published var pedometerDistanceText: String = "?"
    @Published var pedometerNbStepsText: String = "?"

    @Published var angle_Yaw_Z: String = "?"
    @Published var angle_Roll_Y: String = "?"
    @Published var angle_Pitch_X: String = "?"

    var timer: Timer!

    init()
    {
        // init the dataModel used to get Motion infos from the Device
        // it could come from another source : Web service, external hardware, etc
        dataModel = DataModel()
        
    }
    deinit {
        timer?.invalidate()
        timer = nil
    }
    
    
    func startGetActivity_Pedometer() {
        
        dataModel.getActivityResult(completion: { (error, activityResult) in
        
            DispatchQueue.main.async {
                self.activityStatusText = String(describing: activityResult.activityStatus)
            }
        })

        dataModel.getPedometerResult(completion: { (error, pedometerResult) in
            DispatchQueue.main.async {
                if let result = pedometerResult {
                    self.pedometerDistanceText = String(format: "%.2f", result.distance) //String(describing: result.distance)
                    
                    self.pedometerNbStepsText = String(describing: result.numberOfSteps)
                }
            }
        })

    }
    
    func startMotionManager() {
        
        dataModel.startMotionManager()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            self.dataModel.getMotionResult { (error, motionResult) in
                self.angle_Yaw_Z = String(format: "%.2f", motionResult.yaw_Z)
                self.angle_Roll_Y = String(format: "%.2f", motionResult.roll_Y)
                self.angle_Pitch_X = String(format: "%.2f", motionResult.pitch_X)
            }
        })

    }
        
}
