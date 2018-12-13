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

class CompareViewController: UIViewController {
    
    var userPlatform: String = ""
    var userID: String = ""
    var teammateA: String = ""
    var teammateB: String = ""
    let rocketService = RocketService()
    
    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var statImages: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var statShots: UILabel!
    @IBOutlet weak var statSaves: UILabel!
    @IBOutlet weak var statAssists: UILabel!
    @IBOutlet var personalSwipe: UISwipeGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userID = rocketService.fetchSettingsID()
        userPlatform = rocketService.fetchSettingsPlatform()
        teammateA = rocketService.fetchTeammateA()
        teammateB = rocketService.fetchTeammateB()
        
        self.userIDLabel.text = userID + "\n" + teammateA + "\n" + teammateB
        print(self.userIDLabel.text)
        //rocketService.startLoadingAnimation(loadingIcon: loadingIndicator)
        
        Alamofire.request(rocketService.generatePersonalURL(platform: userPlatform, id: userID)).responseJSON { response in
            if (response.result.value != nil) {
                guard
                    let newRankingsDictionary = JSON(response.result.value!)["data"]["statistics"].arrayObject as? [[String : AnyObject]]
                    else {
                        self.userIDLabel.text = "Please check that the username in Settings is valid."
                        self.setAllStatFields(setTo: "N/A")
                        print("(RankViewController): rankingsDictionary was empty")
                        return
                }
                //TODO:
                //0 - ratio, 1 - wins, 2 - goals, 3- saves, 4-shots, 5-mvps, 6-assists
                self.statSaves.text = (newRankingsDictionary[3]["value"] as! String)
                self.statShots.text = (newRankingsDictionary[4]["value"] as! String)
                self.statAssists.text = (newRankingsDictionary[6]["value"] as! String)
            } else {
                self.userIDLabel.text = "Please check that the username in Settings is valid."
                self.setAllStatFields(setTo: "N/A")
            }
        }
        
        Alamofire.request(rocketService.generatePersonalURL(platform: userPlatform, id: teammateA)).responseJSON { response in
            if (response.result.value != nil) {
                guard
                    let newRankingsDictionary = JSON(response.result.value!)["data"]["statistics"].arrayObject as? [[String : AnyObject]]
                    else {
                        self.userIDLabel.text = "Please check that the username in Settings is valid."
                        self.setAllStatFields(setTo: "N/A")
                        print("(RankViewController): rankingsDictionary was empty")
                        return
                }
                //TODO:
                //0 - ratio, 1 - wins, 2 - goals, 3- saves, 4-shots, 5-mvps, 6-assists
                self.statSaves.text = self.statSaves.text! + "\n" + (newRankingsDictionary[3]["value"] as! String)
                self.statShots.text = self.statShots.text! + "\n" + (newRankingsDictionary[4]["value"] as! String)
                self.statAssists.text = self.statAssists.text! + "\n" + (newRankingsDictionary[6]["value"] as! String)
            } else {
                self.userIDLabel.text = "Please check that the username in Settings is valid."
                self.setAllStatFields(setTo: "N/A")
            }
        }
        
        Alamofire.request(rocketService.generatePersonalURL(platform: userPlatform, id: teammateB)).responseJSON { response in
            if (response.result.value != nil) {
                guard
                    let newRankingsDictionary = JSON(response.result.value!)["data"]["statistics"].arrayObject as? [[String : AnyObject]]
                    else {
                        self.userIDLabel.text = "Please check that the username in Settings is valid."
                        self.setAllStatFields(setTo: "N/A")
                        print("(RankViewController): rankingsDictionary was empty")
                        return
                }
                //TODO:
                //0 - ratio, 1 - wins, 2 - goals, 3- saves, 4-shots, 5-mvps, 6-assists
                self.statSaves.text = self.statSaves.text! + "\n" + (newRankingsDictionary[3]["value"] as! String)
                self.statShots.text = self.statShots.text! + "\n" + (newRankingsDictionary[4]["value"] as! String)
                self.statAssists.text = self.statAssists.text! + "\n" + (newRankingsDictionary[6]["value"] as! String)
            } else {
                self.userIDLabel.text = "Please check that the username in Settings is valid."
                self.setAllStatFields(setTo: "N/A")
            }
        }
        
        if (self.userID == "") {
            self.userIDLabel.font = self.userIDLabel.font.withSize(14)
            self.userIDLabel.text = "Set your username & platform in\nthe Settings app, then restart this app."
            self.setAllStatFields(setTo: "N/A")
            
        }
        
        //self.rocketService.stopLoadingAnimation(loadingIcon: self.loadingIndicator)
        
    }
    
    @IBAction func personalRefresh(_ sender: Any) {
        self.viewDidLoad()
    }
    
    func setAllStatFields(setTo: String) {
        self.statSaves.text = setTo
        self.statShots.text = setTo
        self.statAssists.text = setTo
    }

}

