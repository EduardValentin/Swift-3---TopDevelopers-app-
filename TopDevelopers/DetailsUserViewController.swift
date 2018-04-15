//
//  DetailsUserViewController.swift
//  TopDevelopers
//
//  Created by Eduard Valentin on 13/04/2018.
//  Copyright © 2018 Eduard Valentin. All rights reserved.
//

import UIKit

class DetailsUserViewController: UIViewController {

    /*@IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailLocationLabel: UILabel!
    @IBOutlet weak var bronzeBadgesLabel: UILabel!
    @IBOutlet weak var silverBadgesLabel: UILabel!
    @IBOutlet weak var goldBadgesLabel: UILabel!*/
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailLocationLabel: UILabel!
    @IBOutlet weak var bronzeBadgesLabel: UILabel!
    @IBOutlet weak var silverBadgesLabel: UILabel!
    @IBOutlet weak var goldBadgesLabel: UILabel!
    
    var givenImage:UIImage!
    var givenName:String!
    var givenLocation:String!
    var givenBronzeBadges:Int!
    var givenSilverBadges:Int!
    var givenGoldBadges:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailImageView.image = givenImage
        self.detailNameLabel.text = "Userame: " + givenName
        self.detailLocationLabel.text = "Location: " + givenLocation
        self.bronzeBadgesLabel.text = "Bronze badges: " + String(givenBronzeBadges)
        self.silverBadgesLabel.text = "Silver badges: " + String(givenSilverBadges)
        self.goldBadgesLabel.text = "Gold badges: " + String(givenGoldBadges)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func commonInit(image : UIImage, name : String, location : String, bronzeBadges: Int, silverBadges:Int, goldBadges:Int) -> Void {
        self.givenImage = image
        self.givenName = name
        self.givenLocation = location
        self.givenBronzeBadges = bronzeBadges
        self.givenSilverBadges = silverBadges
        self.givenGoldBadges = goldBadges
        
    }
}
