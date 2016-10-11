//
//  Keychain.swift
//  RiftBets
//
//  Created by Brad Bernard on 10/11/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import Foundation
import KeychainSwift

class KeychainManager {
    
    static let sharedInstance = KeychainManager()
    
    private let prefix      = Config.keychainPrefix
    private let keychain    = KeychainSwift(keyPrefix: Config.keychainPrefix)
    
    private let loggedInKey         = "loggedIn"
    private let tokenKey            = "authToken"
    private let deviceTokenKey      = "deviceToken"
    private let deviceIDKey         = "deviceID"
    private let facebookTokenKey    = "facebookToken"
    
    // Private
    
    private func pre(key: String) -> String {
        return (prefix + key)
    }
    
    // Public
    // Getters
    
    func getLoggedIn() -> Bool {
        if let bool = keychain.getBool(pre(loggedInKey)) {
            return bool
        }
        return false
    }
    
    func getToken() -> String? {
        if let token = keychain.get(pre(tokenKey)) {
            return token
        }
        return nil
    }
    
    func getDeviceToken() -> String? {
        if let deviceToken = keychain.get(pre(deviceTokenKey)) {
            return deviceToken
        }
        return nil
    }
    
    func getDeviceID() -> String {
        if let deviceID = keychain.get(pre(deviceIDKey)) {
            return deviceID
        }
        
        let deviceID =  NSUUID().UUIDString
        setDeviceID(deviceID)
        
        return deviceID
    }
    
    func getFacebookToken() -> String? {
        if let facebookToken = keychain.get(pre(facebookTokenKey)) {
            return facebookToken
        }
        return nil
    }
    
    // Setters
    
    func logout() {
        keychain.delete(pre(tokenKey))
        keychain.delete(pre(loggedInKey))
    }
    
    func loginWithToken(token: String) {
        keychain.set(token, forKey: pre(tokenKey))
        setLoggedIn(true)
    }
    
    func setToken(token: String) {
        keychain.set(token, forKey: pre(tokenKey))
    }
    
    func setLoggedIn(value: Bool) {
        keychain.set(value, forKey: pre(loggedInKey))
    }
    
    func setDeviceToken(deviceToken: String) {
        keychain.set(deviceToken, forKey: pre(deviceTokenKey))
    }
    
    func setDeviceID(deviceID: String) {
        keychain.set(deviceID, forKey: pre(deviceIDKey))
    }
    
    func setFacebookToken(facebookToken: String) {
        keychain.set(facebookToken, forKey: pre(facebookTokenKey))
    }
    
}