//
//  User.swift
//  TopDevelopers
//
//  Created by Eduard Valentin on 14/04/2018.
//  Copyright © 2018 Eduard Valentin. All rights reserved.
//

import Foundation
import UIKit

class User: NSObject,NSCoding {
    
    struct Keys{
        static let Username = "name"
        static let Location = "location"
        static let BronzeBadges = "bronzeb"
        static let SilverBadges = "silverb"
        static let GoldBadges = "goldb"
        static let ProfilePicUrl = "profilePicUrl"
        static let ProfilePicImg = "profilePicImg"
    }
    
    let username:String
    let location:String?
    let bronzeBadges:Int
    let silverBadges:Int
    let goldBadges:Int
    let profilePicUrl:String?
    let profilePicImage:UIImage?
    
    //override init() {}
    
    init(username:String,location:String?,bronzeBadges:Int,silverBadges:Int,goldBadges:Int,profilePicUrl:String?,profilePicImg:UIImage?) {
        self.username = username
        
        if let hasLocation = location {
            self.location = hasLocation
        } else {
            self.location = "Location unset"
        }
        
        self.profilePicUrl = profilePicUrl
    
        if let hasProfilePic = profilePicImg {
            self.profilePicImage = hasProfilePic
        } else {
            self.profilePicImage = UIImage(named: "dummyImg")
        }
        
        self.bronzeBadges = bronzeBadges
        self.silverBadges = silverBadges
        self.goldBadges = goldBadges
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let userName = aDecoder.decodeObject(forKey: Keys.Username) as? String else {
            return nil
        }
        self.username = userName
        
        location = aDecoder.decodeObject(forKey: Keys.Location) as? String ?? "Location unset"
        bronzeBadges = aDecoder.decodeObject(forKey: Keys.BronzeBadges) as? Int ?? 0
        silverBadges = aDecoder.decodeObject(forKey: Keys.SilverBadges) as? Int ?? 0
        goldBadges = aDecoder.decodeObject(forKey: Keys.GoldBadges) as? Int ?? 0
        profilePicUrl = aDecoder.decodeObject(forKey: Keys.ProfilePicUrl) as? String ?? "Profile pic URL not set"
        profilePicImage = aDecoder.decodeObject(forKey: Keys.ProfilePicImg) as? UIImage ?? UIImage(named: "dummyImg")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(username, forKey: Keys.Username)
        aCoder.encode(location, forKey: Keys.Location)
        aCoder.encode(profilePicUrl, forKey: Keys.ProfilePicUrl)
        aCoder.encode(profilePicImage, forKey: Keys.ProfilePicImg)
        aCoder.encode(bronzeBadges, forKey: Keys.BronzeBadges)
        aCoder.encode(silverBadges, forKey: Keys.SilverBadges)
        aCoder.encode(goldBadges, forKey: Keys.GoldBadges)
    }
    
}
