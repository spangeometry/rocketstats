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
    
    @IBOutlet weak var rankingsLoadIndicator: UIActivityIndicatorView!
    @IBOutlet var rankingsSwipe: UISwipeGestureRecognizer!
    @IBOutlet weak var rankingsTableView: UITableView!
    @IBOutlet weak var usernameLabel: UILabel!
    var userPlatform: String = ""
    var userID: String = ""
    var rankingsDictionary = [[String:AnyObject]]()
    
    
    let rocketService = RocketService()
    
    override func viewDidLoad() {
        userID = rocketService.fetchSettingsID()
        userPlatform = rocketService.fetchSettingsPlatform()
        usernameLabel.text = userID
        rankingsTableView.dataSource = self
        
        super.viewDidLoad()
        rankingsLoadIndicator.isHidden = false
        rankingsLoadIndicator.startAnimating()
        
        rankingsTableView.isHidden = true
        
        

        Alamofire.request(rocketService.generatePersonalURL(platform: userPlatform, id: userID)).responseJSON { response in
            if JSON(response.result.value!)["success"] == "false" {
                print("json was bad")
            } else {
                guard
                    let newRankingsDictionary = JSON(response.result.value!)["data"]["rankings"].arrayObject as? [[String : AnyObject]]
                else {
                    print("(RankViewController): rankingsDictionary was empty")
                    return
                }
                self.rankingsDictionary = newRankingsDictionary
                self.rankingsTableView.reloadData()
                self.rankingsLoadIndicator.isHidden = true
                self.rankingsLoadIndicator.stopAnimating()
                self.rankingsTableView.isHidden = false
            }
        }
        
        
    }

    @IBAction func rankRefresh(_ sender: Any) {
        self.viewDidLoad()
    }
}

extension RankViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankingsDictionary.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "rankingCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "rankingCell")
        }
        let rank = rankingsDictionary[indexPath.row]
        cell!.textLabel?.text = rank["playlist"] as? String
        cell!.detailTextLabel?.text = rank["rank"] as? String
        return cell!
    }
    
    
}
