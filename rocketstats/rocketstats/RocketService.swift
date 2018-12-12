//
//  RocketService.swift
//  rocketstats
//
//  Created by Sam on 12/12/18.
//  Copyright © 2018 Sam. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RocketService {
    
    func loadRankingsJSON(platform: String, id: String) -> [[String:AnyObject]] {
        var rankingsDictionary = [[String:AnyObject]]()
        
        Alamofire.request(generatePersonalURL(platform: platform, id: id)).responseJSON {
            (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let dataFromJSON = JSON(responseData.result.value!)
                print(dataFromJSON)
                if dataFromJSON["success"].description == "false" {
                    print("(RocketService) JSON: Retrieving JSON data failed.")
                    return
                } else {
                    print("(RocketService) JSON: Retrieving JSON data succeeded.")
                }
                
                if let resData = dataFromJSON["data"]["rankings"].arrayObject {
                    rankingsDictionary = resData as! [[String:AnyObject]]
                }

                print(rankingsDictionary)
            }
        }
        return rankingsDictionary
    }

    func fetchSettingsID() -> String{
        let defaults = UserDefaults.standard
        let appDefaults = ["settingsUsername": ""]
        defaults.register(defaults: appDefaults)
        defaults.synchronize()
        
        return defaults.string(forKey: "settingsUsername")!
    }
    
    func fetchSettingsPlatform() -> String{
        let defaults = UserDefaults.standard
        let appDefaults = ["settingsPlatform": ""]
        defaults.register(defaults: appDefaults)
        defaults.synchronize()
        
        return defaults.string(forKey: "settingsPlatform")!
    }
    
    //Generates JSON URL
    func generatePersonalURL(platform: String, id: String) -> String {
        var personalJSON = "https://wrapapi.com/use/serioussamix/rocketleague/statistics/0.0.3?playerID="
        personalJSON += id
        personalJSON += "&platform="
        personalJSON += platform
        personalJSON += "&wrapAPIKey=AaiubOD8r3JgZLk3FRIrcjMEzqTqqnZN"
        return personalJSON;
    }

    
}

