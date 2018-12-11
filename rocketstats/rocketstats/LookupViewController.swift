//
//  LookupViewController.swift
//  rocketstats
//  Handles the View Controller for a looked-up user's statistics
//
//  Created by Sam on 11/29/18.
//  Copyright © 2018 Sam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LookupViewController: UIViewController {
    
    var userPlatform: String = ""
    var userID: String = ""
    @IBOutlet weak var statShots: UILabel!
    @IBOutlet weak var statSaves: UILabel!
    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var statAssists: UILabel!
    @IBOutlet weak var lookupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetchSettings()
        self.userIDLabel.text = "meevelad"
        //loadPersonalJSON(platform: "ps", userID: "meevelad")
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    func setAllStatFields(setTo: String) {
        self.statSaves.text = setTo
        self.statShots.text = setTo
        self.statAssists.text = setTo
    }
    @IBAction func lookupButtonPressed(_ sender: Any) {
        loadPersonalJSON(platform: "ps", userID: "meevelad")
    }
    
    func loadPersonalJSON(platform: String, userID: String) {
        if (userID == "") {
            print("Settings: username was not set.")
            self.userIDLabel.numberOfLines = 0
            self.userIDLabel.font = self.userIDLabel.font.withSize(14)
            self.userIDLabel.text = "Set your username & platform in\nthe Settings app."
            self.setAllStatFields(setTo: "N/A")
            return
        }
        
        Alamofire.request(generatePersonalURL(platform: platform, userID: userID)).responseJSON {
            (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let dataFromJSON = JSON(responseData.result.value!)
                //print(swiftyJSONVar)
                if dataFromJSON["success"].description == "false" {
                    print("JSON: Retrieving JSON data failed.")
                    self.userIDLabel.numberOfLines = 0
                    self.userIDLabel.font = self.userIDLabel.font.withSize(14)
                    self.userIDLabel.text = "Failed to retrieve statistics.\nCheck your username & platform\nin the Settings app."
                    self.setAllStatFields(setTo: "N/A")
                    return
                } else {
                    print("JSON: Retrieving JSON data succeeded.")
                }
                //Get shots
                if let statValue = dataFromJSON["data"]["performance"][5]["statistic"]["value"].string {
                    self.statShots.text = statValue
                }
                //Get saves
                if let statValue = dataFromJSON["data"]["performance"][4]["statistic"]["value"].string {
                    self.statSaves.text = statValue
                }
                //Get assists
                if let statValue = dataFromJSON["data"]["performance"][7]["statistic"]["value"].string {
                    self.statAssists.text = statValue
                }
            }
        }
    }
    
    func fetchSettings() {
        let defaults = UserDefaults.standard
        let appDefaults = ["settingsUsername": "","settingsPlatform": ""]
        defaults.register(defaults: appDefaults)
        defaults.synchronize()
        
        userID = defaults.string(forKey: "settingsUsername")!
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

