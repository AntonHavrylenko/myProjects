//
//  Stopwatch.swift
//  Lesson25
//
//  Created by Anton Havrylenko on 20.03.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import Foundation

final class Stopwatch {
    
    private var startTime: NSDate?
    
    var finalTime: NSTimeInterval {
        if let startTime = startTime {
            return -startTime.timeIntervalSinceNow
        } else {
            return 0
        }
    }
    
    var finalTimeAsString: String {
        return String(format: "%02d:%02d.%02d",
            Int(finalTime / 60), Int(finalTime % 60), Int(finalTime * 100 % 100))
    }
    
    var isRunning: Bool {
        return startTime != nil
    }
    
    func start() {
        startTime = NSDate()
    }
    
    func stop() {
        startTime = nil
    }

}