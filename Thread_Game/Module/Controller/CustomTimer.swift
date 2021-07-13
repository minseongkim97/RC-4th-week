////
////  CustomTimer.swift
////  Thread_Game
////
////  Created by MIN SEONG KIM on 2021/07/14.
////
//
//import UIKit
//
//class CustomTimer {
//    typealias Update = (Int)->Void
//    var timer: Timer?
//    var count: Int = 0
//    var update: Update?
//
//    init(update:@escaping Update) {
//        self.update = update
//    }
//
//    func start() {
//        timer = Timer(timeInterval: 1.0, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
//    }
//
//    func stop() {
//        if let timer = timer {
//            timer.invalidate()
//        }
//    }
//
//    @objc func timerUpdate() {
//        count += 1;
//        if let update = update {
//            update(count)
//        }
//    }
//}
