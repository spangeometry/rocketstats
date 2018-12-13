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
    let rocketService = RocketService()
    
    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var statImages: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var statShots: UILabel!
    @IBOutlet weak var statSaves: UILabel!
    @IBOutlet weak var statAssists: UILabel!
    @IBOutlet weak var statRatio: UILabel!
    @IBOutlet weak var statGoals: UILabel!
    @IBOutlet weak var statMVPs: UILabel!
    @IBOutlet var personalSwipe: UISwipeGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userID = rocketService.fetchSettingsID()
        userPlatform = rocketService.fetchSettingsPlatform()
        
        self.userIDLabel.text = userID
        rocketService.startLoadingAnimation(loadingIcon: loadingIndicator)
        
       
        
        
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
                self.statRatio.text = (newRankingsDictionary[0]["value"] as! String)
                self.userIDLabel.text = (self.userIDLabel.text! + "\n" + (newRankingsDictionary[1]["value"] as! String) + " wins")
                self.statGoals.text = (newRankingsDictionary[2]["value"] as! String)
                self.statSaves.text = (newRankingsDictionary[3]["value"] as! String)
                self.statShots.text = (newRankingsDictionary[4]["value"] as! String)
                self.statMVPs.text = (newRankingsDictionary[5]["value"] as! String)
                self.statAssists.text = (newRankingsDictionary[6]["value"] as! String)
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
        
        self.rocketService.stopLoadingAnimation(loadingIcon: self.loadingIndicator)
        
    }
    
    @IBAction func personalRefresh(_ sender: Any) {
        self.viewDidLoad()
    }
    
    func setAllStatFields(setTo: String) {
        self.statRatio.text = setTo
        self.statGoals.text = setTo
        self.statSaves.text = setTo
        self.statShots.text = setTo
        self.statMVPs.text = setTo
        self.statAssists.text = setTo
    }

}

