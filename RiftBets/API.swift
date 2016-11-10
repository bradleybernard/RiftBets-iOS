//
//  API.swift
//  RiftBets
//
//  Created by Brad Bernard on 10/11/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias JSONCompletion  = (json: JSON, error: NSError?) -> Void
typealias BoolCompletion  = (success: Bool, error: NSError?) -> Void
typealias JSONBoolCompletion = (success: Bool, json: JSON, error: NSError?) -> Void

class RemoteManager {
    
    // Default Instance
    static let sharedInstance =
        RemoteManager(
            base: Config.baseAPI,
            version: Config.versionAPI,
            debug: Config.debug
    )
    
    private let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
    private let alamofireManager : Alamofire.Manager
    
    // Defaults
    private var again = " Please try again."
    private var base = "" // "{protocol}://{domain}/{version}/"
    private var version = "" // "v1"
    private var debug = false // true
    private var built = "" // https://riftbets.dev/api/
    
    // Init
    required init(base: String, version: String, debug: Bool) {
        self.base = base
        self.version = version
        self.debug = debug
        
        sessionConfig.timeoutIntervalForRequest = Double(Config.timeoutAPI)
        sessionConfig.timeoutIntervalForResource = Double(Config.timeoutAPI)
        
        alamofireManager = Alamofire.Manager(configuration: sessionConfig)
        
        self.built = buildBase()
        print(self.built)
    }
    
    // Private
    private func buildBase() -> String {
        let url = base.stringByReplacingOccurrencesOfString("{version}", withString: version)
        if !debug {
            return url.stringByReplacingOccurrencesOfString("{domain}", withString: "bradberard.ngrok.io").stringByReplacingOccurrencesOfString("{protocol}", withString: "http")
        } else {
            return url.stringByReplacingOccurrencesOfString("{domain}", withString: "riftbets.dev").stringByReplacingOccurrencesOfString("{protocol}", withString: "http")
        }
    }
    
    private func firstError(errors: [String : JSON]) -> String {
        let sorted = errors.sort { $0.0 < $1.0 }
        for (_, json) in sorted {
            for error in json {
                return error.1.stringValue
            }
        }
        return "An unknown error has occurred."
    }
    
    private func request(url: String, method: Alamofire.Method, parameters: [String: String], headers: [String: String], completion: JSONCompletion) {
        
        alamofireManager.request(method, url, parameters: parameters, encoding: .URL, headers: headers)
            .responseJSON { (response) -> Void in
                
                guard let data = response.result.value else {
                    return completion(json: [:], error: NSError(domain: self.again("An internal server error occured."), code: 10001, userInfo: nil))
                }
                
                let json = JSON(data)
                
                if let message = json["message"].string {
                    return completion(json: json, error: NSError(domain: message, code: (response.response?.statusCode)!, userInfo: nil))
                }
                
                if let errors = json["errors"].dictionary {
                    return completion(json: json, error: NSError(domain: self.firstError(errors), code: (response.response?.statusCode)!, userInfo: nil))
                }
                
                //print(json)
                
                return completion(json: json, error: nil)
        }
    }
    
    private func post(endpoint: String, parameters: [String: String], completion: JSONCompletion) {
        request(url(endpoint), method: .POST, parameters: parameters, headers: authHeader(), completion: completion)
    }
    
    private func get(endpoint: String, parameters: [String: String], completion: JSONCompletion) {
        request(url(endpoint), method: .GET, parameters: parameters, headers: authHeader(), completion: completion)
    }
    
    private func url(path: String) -> String {
        return (built + path)
    }
    
    private func again(error: String) -> String {
        return (error + again)
    }
    
    private func authHeader() -> [String: String] {
        if let token = KeychainManager.sharedInstance.getToken() {
            return ["Authorization": "Bearer " + token]
        }
        return [:]
    }
    
    private func withDevice(inout parameters: [String: String]) {
        parameters["device_version"] = DeviceHelper.getVersion()
        parameters["device_screen_size"] = DeviceHelper.getScreenSize()
        parameters["device_type"] = DeviceHelper.getType()
        parameters["device_id"] = DeviceHelper.getID()
        
        if let deviceToken = KeychainManager.sharedInstance.getDeviceToken() {
            parameters["device_token"] = deviceToken
        }
    }
    
    private func afterFacebook(json: JSON, error: NSError?, completion: JSONCompletion) {
        
        if let error = error {
            return completion(json: json, error: error)
        }
        
        guard let token = json["token"].string else {
            return completion(json: json, error: NSError(domain: again("Facebook auth failed."), code: 10002, userInfo: nil))
        }
        
        KeychainManager.sharedInstance.loginWithToken(token)
        
        return completion(json: json, error: nil)
    }
    
    // Public
    func facebook(completion: JSONCompletion) {
        
        guard let facebookToken = KeychainManager.sharedInstance.getFacebookToken() else {
            return completion(json: nil, error: NSError(domain: again("No Facebook token set."), code: 10005, userInfo: nil))
        }
        
        var params = ["facebook_access_token": facebookToken]
        withDevice(&params)
        
        post("auth/facebook", parameters: params, completion: { (json, error) -> Void in
            
            self.afterFacebook(json, error: error, completion: completion)
            
        })
    }
    
    private func afterMatchSchedule(json: JSON, error: NSError?, completion: JSONCompletion){
        
        if let error = error {
            return completion(json: json, error: error)
        }
        
        return completion(json: json, error: nil)
    }
    
    private func afterMatchDetail(json: JSON, error: NSError?, completion: JSONCompletion){
        
        if let error = error {
            return completion(json: json, error: error)
        }
        
        return completion(json: json, error: nil)
    }
    
    func matchSchedule(completion: JSONCompletion){
        
        get("schedule", parameters: [:], completion: { (json, error) -> Void in
            
            self.afterMatchSchedule(json, error: error, completion: completion)
        })
    }
    func matchDetail(matchid:String, completion: JSONCompletion){
        let params = [
            "match_id": matchid
        ]
        print(params)
        get("match", parameters: params, completion: { (json, error) -> Void in
            
            self.afterMatchDetail(json, error: error, completion: completion)
        })
    }
    
    
    
}