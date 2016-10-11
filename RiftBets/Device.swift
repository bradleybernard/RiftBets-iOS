//
//  Device.swift
//  RiftBets
//
//  Created by Brad Bernard on 10/11/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import Foundation
import Device

class DeviceHelper {
    
    static func getID() -> String {
        return KeychainManager.sharedInstance.getDeviceID()
    }
    
    static func getVersion() -> String {
        switch Device.version() {
        case .iPhone4:       return "iphone_4"
        case .iPhone4S:      return "iphone_4s"
        case .iPhone5:       return "iphone_5"
        case .iPhone5C:      return "iphone_5c"
        case .iPhone5S:      return "iphone_5s"
        case .iPhone6:       return "iphone_6"
        case .iPhone6S:      return "iphone_6s"
        case .iPhone6Plus:   return "iphone_6_plus"
        case .iPhone6SPlus:  return "iphone_6s_plus"
            
        case .iPad1:         return "ipad_1"
        case .iPad2:         return "ipad_2"
        case .iPad3:         return "ipad_3"
        case .iPad4:         return "ipad_4"
        case .iPadAir:       return "ipad_air"
        case .iPadAir2:      return "ipad_air_2"
        case .iPadMini:      return "ipad_mini"
        case .iPadMini2:     return "ipad_mini_2"
        case .iPadMini3:     return "ipad_mini_3"
        case .iPadMini4:     return "ipad_mini_4"
        case .iPadPro:       return "ipad_pro"
            
        case .iPodTouch1Gen: return "ipod_touch_1_gen"
        case .iPodTouch2Gen: return "ipod_touch_2_gen"
        case .iPodTouch3Gen: return "ipod_touch_3_gen"
        case .iPodTouch4Gen: return "ipod_touch_4_gen"
        case .iPodTouch5Gen: return "ipod_touch_5_gen"
        case .iPodTouch6Gen: return "ipod_touch_6_gen"
            
        case .Simulator:    return "simulator"
            
        default:            return "unknown"
        }
    }
    
    static func getScreenSize() -> String {
        switch Device.size() {
        case .Screen3_5Inch:    return "3_5_inch"
        case .Screen4Inch:      return "4_inch"
        case .Screen4_7Inch:    return "4_7_inch"
        case .Screen5_5Inch:    return "5_5_inch"
        case .Screen7_9Inch:    return "7_9_inch"
        case .Screen9_7Inch:    return "9_7_inch"
        case .Screen12_9Inch:   return "12_9_inch"
            
        default:                return "unknown"
        }
    }
    
    static func getType() -> String {
        switch Device.type() {
        case .iPod:         return "ipod"
        case .iPhone:       return "iphone"
        case .iPad:         return "ipad"
        case .Simulator:    return "simulator"
            
        default:            return "unknown"
        }
    }
    
}