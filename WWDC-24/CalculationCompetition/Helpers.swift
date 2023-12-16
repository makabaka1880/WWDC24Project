//
//  Helpers.swift
//  WWDC-24
//
//  Created by SeanLi on 12/16/23.
//

import Foundation

func DidigitTimeConversion(_ time: Int) -> String {
    let secondaryTime = time % 60
//    let reminderTime = time - secondaryTime
//
//    let timeString = String(reminderTime) + String(reminderTime).count * "0"
//    let secondaryTimeString = String(secondaryTime) + String(secondaryTime).count * "0"
    return "\(String(format: "%02d", (time-secondaryTime)/60)):\(String(format: "%02d", secondaryTime))"
}
