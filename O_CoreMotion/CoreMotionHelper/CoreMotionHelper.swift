//
//  CoreMotionHelper.swift
//  O_CoreMotion
//
//  Created by olivier robin on 30/01/2021.
//

import Foundation
import CoreMotion

enum CoremotionError: Error {
    case activity_NoData
    case pedometer_NoData
}





class CoreMotionHelper {
    
    let activityManager = CMMotionActivityManager()
    let pedometer = CMPedometer()
    let motionManager = CMMotionManager()
    
    
    
    deinit {
        self.activityManager.stopActivityUpdates()
        self.pedometer.stopUpdates()
        
        //motionManager.stopGyroUpdates()
        //motionManager.stopMagnetometerUpdates()
        //motionManager.stopAccelerometerUpdates()
        motionManager.stopDeviceMotionUpdates()
    }
    
    func startMotionManager() {
        
        //motionManager.startGyroUpdates()
        //motionManager.startAccelerometerUpdates()
        //motionManager.startMagnetometerUpdates()
        motionManager.startDeviceMotionUpdates()
    }
    
    // radians to degrees
    private func radiansToDegree(radians : Double) -> Double {
        return 180 * radians / Double.pi
    }
    
    
    // Get information about motion of the device :
    // angle of the device, gyro value ( movement acceleration for ex.)
    // magneto value, etc...
    // here, to be simple, I get devbice angle...
    
    // Careful : it need to be called each time I want an updated result !!!
    
    func getMotionResult(completion:@escaping (_ error: Error?, _ motionResult: MotionResult ) -> Void) {
        
        let result = MotionResult()
        
        // Will get the device orientation on 3 axis : X, Y, Z.
        if let motion = self.motionManager.deviceMotion {
            let attitude = motion.attitude
            
            result.pitch_X = radiansToDegree( radians: attitude.pitch )
            result.roll_Y = radiansToDegree( radians: attitude.roll )
            result.yaw_Z = radiansToDegree( radians: attitude.yaw )
            
            completion(nil, result)
        }
        
        
        //        if let gyroData = self.motionManager.gyroData {
        //            print("gyroData")
        //            print(gyroData)
        //
        //        }
        //            if let accelerometerData = self.motionManager.accelerometerData {
        //                print("accelerometer")
        //                print(accelerometerData)
        //            }
        //            if let magnetometerData = self.motionManager.magnetometerData {
        //                print("magnetometerData")
        //                print(magnetometerData)
        //            }
        //            if let deviceMotion = self.motionManager.deviceMotion {
        //                print("deviceMotion")
        //                print(deviceMotion)
        //            }
        
        
    }
    
    
    // Return in completion handler the activity status. ex. wlking, running, unknown...
    // completion will be called automatically, each time there is an updated result
    func getActivityResult(completion:@escaping (_ error: Error?, _ activityStatus: ActivityResult ) -> Void) {
        
        self.activityManager.startActivityUpdates(to: OperationQueue.main) { (data) in
            if let activity = data {
                print("activity status event")
                
                if activity.walking == true {
                    print("activity walking")
                    
                    completion( nil, ActivityResult(status:  .walking))
                } else if activity.running == true {
                    print("activity running")
                    completion( nil, ActivityResult(status:  .running))
                } else if activity.automotive == true {
                    print("activity automotive")
                    completion( nil, ActivityResult(status:  .automotive))
                } else if activity.cycling == true {
                    print("activity cycling")
                    completion( nil, ActivityResult(status:  .automotive))
                }
                else {
                    print("activity ???")
                    
                    completion( nil, ActivityResult(status:  .unknown))
                }
            }
            else {
                print("activity no data")
                
                completion( CoremotionError.activity_NoData, ActivityResult(status:  .unknown))
            }
        }
        
    }
    
    // Return in completion handler some information about pedometer. ex. distance ( if known ), steps, and more ( see documentation )
    // completion will be called automatically, each time there is an updated result
    func getPedometerResult(completion:@escaping (_ error: Error?, _ pedometerResult: PedometerResult? ) -> Void) {
        
        // TODO : check capabilities using : pedometer.isStepCountingAvailable(), pedometer.isDistanceAvailable()
        
        self.pedometer.startUpdates(from: Date()) { (data, error) in
            if error == nil {
                if let response = data {
                    
                    //                    print("Number Of Steps == \(response.numberOfSteps)")
                    //                    print("distance == \(response.distance ?? 0)")
                    
                    let result = PedometerResult()
                    
                    if let distance = response.distance {
                        result.distance = distance.floatValue
                    }
                    
                    result.numberOfSteps = response.numberOfSteps
                    
                    completion(nil, result )
                }
                else {
                    completion(CoremotionError.pedometer_NoData, nil )
                }
            }
        }
    }
}
