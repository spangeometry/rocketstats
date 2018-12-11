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
    
    var userPlatform: String = ""
    var userID: String = ""
    @IBOutlet weak var statShots: UILabel!
    @IBOutlet weak var statSaves: UILabel!
    @IBOutlet weak var userIDLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSettings()
        loadPersonalJSON(platform: userPlatform, userID: userID)
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    func loadPersonalJSON(platform: String, userID: String) {
        Alamofire.request(generatePersonalURL(platform: userPlatform, userID: userID)).responseJSON {
            (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJSONVar = JSON(responseData.result.value!)
                print(swiftyJSONVar)
                if swiftyJSONVar["success"].description == "false" {
                    print("no success")
                    self.userIDLabel.text = "no success"
                    return
                }
                if let testValue = swiftyJSONVar["data"]["performance"][5]["statistic"]["value"].string {
                    self.statShots.text = testValue
                    print(testValue)
                    self.userIDLabel.text = "success"
                }
                if let testValue = swiftyJSONVar["data"]["performance"][4]["statistic"]["value"].string {
                    self.statSaves.text = testValue
                    print(testValue)
                }
            }
        }
    }
    
    func fetchSettings() {
        let defaults = UserDefaults.standard
        let appDefaults = ["settingsUsername": "serioussamix","settingsPlatform": "ps"]
        defaults.register(defaults: appDefaults)
        defaults.synchronize()
        
        userID = defaults.string(forKey: "settingsUsername")!
        self.userIDLabel.text = userID
        userPlatform = defaults.string(forKey: "settingsPlatform")!
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

