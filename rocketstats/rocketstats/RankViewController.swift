//
//  RankViewController.swift
//  rocketstats
//  Handles the View Controller for rankings
//
//  Created by Sam on 12/11/18.
//  Copyright © 2018 Sam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RankViewController: UIViewController {
    
    @IBOutlet weak var rankingsTableView: UITableView!
    var userPlatform: String = ""
    var userID: String = ""
    var rankingsJSON: JSON = []
    var rankingsArray = [String] ()
    var rankingsDictionary = [[String:AnyObject]]()
    
    let rocketService = RocketService()
    
    override func viewDidLoad() {
        
        fetchSettings()
        rankingsTableView.dataSource = self
        super.viewDidLoad()
        //loadPersonalJSON(platform: userPlatform, userID: userID)
        /*
        rankingsDictionary = rocketService.loadRankingsJSON(platform: userPlatform, id: userID) { response in
            print("test")
        }

        rankingsDictionary = rocketService.getUserInfo(platform: userPlatform, id: userID) { response in
            print("test")
            self.rankingsTableView.reloadData()
        }
        */
        /*
         Alamofire.request(generatePersonalURL(platform: userPlatform, userID: userID)).responseJSON { response in
            
            self.rankingsTableView.reloadData()
        }*/
        let personalurlstring = generatePersonalURL(platform: userPlatform, userID: userID)
        print(personalurlstring)
        let url = URL(string: personalurlstring)
        Alamofire.request(url!).responseJSON { response in
            self.rankingsDictionary = JSON(response.result.value!)["data"]["rankings"].arrayObject as! [[String : AnyObject]]
            self.rankingsTableView.reloadData()
        }
        
        
    }
    
    func loadPersonalJSON(platform: String, userID: String) {
        if (userID == "") {
            print("(Personal) Settings: username was not set.")
            //self.userIDLabel.numberOfLines = 0
            //self.userIDLabel.font = self.userIDLabel.font.withSize(14)
            //self.userIDLabel.text = "Set your username & platform in\nthe Settings app, then restart this app."
            //self.setAllStatFields(setTo: "N/A")
            return
        }
        
        Alamofire.request(generatePersonalURL(platform: platform, userID: userID)).responseJSON {
            (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let dataFromJSON = JSON(responseData.result.value!)
                //print(swiftyJSONVar)
                if dataFromJSON["success"].description == "false" {
                    print("(Personal) JSON: Retrieving JSON data failed.")
                    //self.userIDLabel.text = "Failed to retrieve statistics.\nCheck your username & platform\nin the Settings app, then restart this app."
                    return
                } else {
                    print("(Personal) JSON: Retrieving JSON data succeeded.")
                }

                if let resData = dataFromJSON["data"]["rankings"].arrayObject {
                    self.rankingsDictionary = resData as! [[String:AnyObject]]
                }
                if self.rankingsDictionary.count > 0 {
                    self.rankingsTableView.reloadData()
                }
                print(self.rankingsDictionary)
            }
        }
    }
 /*
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        print("In deque func")
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "jsonCell")!
        var dict = rankingsDictionary[indexPath.row]

        cell.textLabel?.text = dict["playlist"] as? String
        cell.detailTextLabel?.text = dict["rank"] as? String
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankingsDictionary.count
    }
  */
    func fetchSettings() {
        let defaults = UserDefaults.standard
        let appDefaults = ["settingsUsername": "","settingsPlatform": ""]
        defaults.register(defaults: appDefaults)
        defaults.synchronize()
        
        userID = defaults.string(forKey: "settingsUsername")!
        userPlatform = defaults.string(forKey: "settingsPlatform")!
    }
    
    func generatePersonalURL(platform: String, userID: String) -> String {
        var personalJSON = "https://wrapapi.com/use/serioussamix/rocketleague/statistics/0.0.2?playerID="
        personalJSON += userID
        personalJSON += "&platform="
        personalJSON += platform
        personalJSON += "&wrapAPIKey=AaiubOD8r3JgZLk3FRIrcjMEzqTqqnZN"
        return personalJSON;
    }

}

extension RankViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankingsDictionary.count
    }
/*
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("In deque func")
        let cell = UITableViewCell()
        let city = rankingsDictionary[indexPath.row]
        //cell.detailTextLabel?.text = city["playlist"] as? String
        cell.textLabel?.text = city["rank"] as? String
        return cell
    }
*/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("In deque func")
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "reuseIdentifier")
        }
        let city = rankingsDictionary[indexPath.row]
        cell!.textLabel?.text = city["playlist"] as? String
        cell!.detailTextLabel?.text = city["rank"] as? String
        return cell!
    }
    
    
}
