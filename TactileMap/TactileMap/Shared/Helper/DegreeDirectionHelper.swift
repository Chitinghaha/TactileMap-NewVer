//
//  DegreeDirectionHelper.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/31.
//

import Foundation

extension CGFloat {
    func clockDirection() -> String {
        var direction = ""
        
        if -75 > self && self >= -105 {
            direction = "十二點鐘"
        }
        else if -45 > self && self >= -75 {
            direction = "一點鐘"
        }
        else if -15 > self && self >= -45 {
            direction = "兩點鐘"
        }
        else if 15 > self && self >= -15 {
            direction = "三點鐘"
        }
        else if 45 > self && self >= 15 {
            direction = "四點鐘"
        }
        else if 75 > self && self >= 45 {
            direction = "五點鐘"
        }
        else if 105 > self && self >= 75 {
            direction = "六點鐘"
        }
        else if 135 > self && self >= 105 {
            direction = "七點鐘"
        }
        else if 165 > self && self >= 135 {
            direction = "八點鐘"
        }
        else if -165 > self || self >= 165 {
            direction = "九點鐘"
        }
        else if -135 > self && self >= -165 {
            direction = "十點鐘"
        }
        else if -105 > self && self >= -135 {
            direction = "十一點鐘"
        }

        
        return direction
    }
}
