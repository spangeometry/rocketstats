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
    
    func startLoadingAnimation(loadingIcon: UIActivityIndicatorView) {
        loadingIcon.isHidden = false
        loadingIcon.startAnimating()
    }
    
    func stopLoadingAnimation(loadingIcon: UIActivityIndicatorView) {
        loadingIcon.isHidden = true
        loadingIcon.stopAnimating()
    }

    func fetchSettingsID() -> String{
        let defaults = UserDefaults.standard
        let appDefaults = ["settingsUsername": ""]
        defaults.register(defaults: appDefaults)
        defaults.synchronize()
        
        return defaults.string(forKey: "settingsUsername")!
    }
    
    func fetchTeammateA() -> String{
        let defaults = UserDefaults.standard
        let appDefaults = ["settingsTeammateA": ""]
        defaults.register(defaults: appDefaults)
        defaults.synchronize()
        
        return defaults.string(forKey: "settingsTeammateA")!
    }
    
    func fetchTeammateB() -> String{
        let defaults = UserDefaults.standard
        let appDefaults = ["settingsTeammateB": ""]
        defaults.register(defaults: appDefaults)
        defaults.synchronize()
        
        return defaults.string(forKey: "settingsTeammateB")!
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

    func generateStatisticsDictionary(platform: String, id: String) -> [[String:AnyObject]] {
        var rankingsDict = [[String : AnyObject]]()
        Alamofire.request(generatePersonalURL(platform: platform, id: id)).responseJSON { response in
            if (response.result.value != nil) {
                guard
                    let newRankingsDictionary = JSON(response.result.value!)["data"]["statistics"].arrayObject as? [[String : AnyObject]]
                    else {
                        print("(RankViewController): rankingsDictionary was empty")
                        return
                    }
                rankingsDict = newRankingsDictionary
            }
        }
        return rankingsDict
    }
}
