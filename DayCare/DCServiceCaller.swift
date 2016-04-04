//
//  DCServiceCaller.swift
//  DayCare
//
//  Created by Tayal, Rishabh on 4/4/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import AFNetworking

class DCServiceCaller: NSObject {

typealias Completion = (result: AnyObject?, error: NSError?) -> Void

    class func sendPush(pushText: String, completion: Completion) {
        let params = ["where": ["deviceType": ["$in": ["ios"]]] ,"data": ["title": "Hey", "alert": "Hello"]]
        let headers = ["X-Parse-Application-Id": "myAppId", "X-Parse-Master-Key": "myMasterKey"]
        makeAPICall("https://arcane-fortress-10529.herokuapp.com/parse/push", method: "POST", headers: headers, params: params, completion: completion)
    }
    
    private class func makeAPICall(url: String, method: String, headers: [String: String]?, params: [String: AnyObject]?, completion: Completion) {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = method
        
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        request.addValue("aplication/json", forHTTPHeaderField: "Content-Type")
        
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (d: NSData?, r: NSURLResponse?, e: NSError?) in
            if let data = d {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
                    completion(result: json, error: nil)
                } catch {
                    completion(result: nil, error: nil)
                }
            } else {
                completion(result: nil, error: e)
            }
        }.resume()
    }
}
