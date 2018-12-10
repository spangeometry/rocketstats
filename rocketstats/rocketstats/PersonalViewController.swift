//
//  PersonalViewController.swift
//  rocketstats
//  Handles the View Controller for a user's personal statistics
//
//  Created by Sam on 11/29/18.
//  Copyright © 2018 Sam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PersonalViewController: UIViewController {
    
    var userPlatform: String = "ps"
    var userID: String = "serioussamix"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Alamofire.request(generatePersonalURL(platform: userPlatform, userID: userID)).responseJSON {
            (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJSONVar = JSON(responseData.result.value!)
                //print(swiftyJSONVar)
                if let testValue = swiftyJSONVar["data"]["performance"][0]["statistic"]["title"].string {
                    print(testValue)
                }
            }
        }
        
    }
    
    func fetchPersonalData(completion: @escaping ([String:Any]?, Error?) -> Void) {

        
        
    }
    
    func generatePersonalURL(platform: String, userID: String) -> String {
        var personalJSON = "https://wrapapi.com/use/serioussamix/rocketleague/statistics/0.0.1?playerID="
        personalJSON += userID
        personalJSON += "&platform="
        personalJSON += platform
        personalJSON += "&wrapAPIKey=AaiubOD8r3JgZLk3FRIrcjMEzqTqqnZN"
        return personalJSON;
    }


}

