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
    
    var _username:String! = ""
    var _location:String! = ""
    var _bronzeBadges:Int! = 0
    var _silverBadges:Int! = 0
    var _goldBadges:Int! = 0
    var _profilePicUrl:String! = ""
    var _profilePicImage:UIImage?
    
    override init() {}
    
    init(username:String,location:String,bronzeBadges:Int,silverBadges:Int,goldBadges:Int,profilePicUrl:String,profilePicImg:UIImage?) {
        self._username = username
        self._location = location
        self._profilePicUrl = profilePicUrl
        self._profilePicImage = profilePicImg
        self._bronzeBadges = bronzeBadges
        self._silverBadges = silverBadges
        self._goldBadges = goldBadges
    }
    
    required init?(coder aDecoder: NSCoder) {
        if let usernameObj = aDecoder.decodeObject(forKey: Keys.Username) as? String {
            _username = usernameObj
        }
        
        if let locationObj = aDecoder.decodeObject(forKey: Keys.Location) as? String {
            _location = locationObj
        }
        
        if let bronzeBadgesObj = aDecoder.decodeObject(forKey: Keys.BronzeBadges) as? Int {
            _bronzeBadges = bronzeBadgesObj
        }
        
        if let silverBadgesObj = aDecoder.decodeObject(forKey: Keys.SilverBadges) as? Int {
            _silverBadges = silverBadgesObj
        }
        
        if let goldBadgesObj = aDecoder.decodeObject(forKey: Keys.GoldBadges) as? Int {
            _goldBadges = goldBadgesObj
        }
        
        if let profilePicUrlObj = aDecoder.decodeObject(forKey: Keys.ProfilePicUrl) as? String {
            _profilePicUrl = profilePicUrlObj
        }
        
        if let profilePicImgObj = aDecoder.decodeObject(forKey: Keys.ProfilePicImg) as? UIImage {
            _profilePicImage = profilePicImgObj
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(_username, forKey: Keys.Username)
        aCoder.encode(_location, forKey: Keys.Location)
        aCoder.encode(_profilePicUrl, forKey: Keys.ProfilePicUrl)
        aCoder.encode(_profilePicImage, forKey: Keys.ProfilePicImg)
        aCoder.encode(_bronzeBadges, forKey: Keys.BronzeBadges)
        aCoder.encode(_silverBadges, forKey: Keys.SilverBadges)
        aCoder.encode(_goldBadges, forKey: Keys.GoldBadges)
    }
    
    var Username: String{
        get {
            return _username
        }
        set {
            _username = newValue
        }
    }
    
    var Location: String{
        get{
            return _location
        }
        set{
            _location = newValue
        }
    }
    
    var BronzeBadges:Int{
        get{
            return _bronzeBadges
        }
        set{
            _bronzeBadges = newValue
        }
    }
    
    var SilverBadges:Int{
        get{
            return _silverBadges
        }
        set{
            _silverBadges = newValue
        }
    }
    
    var GoldBadges:Int{
        get{
            return _goldBadges
        }
        set{
            _goldBadges = newValue
        }
    }
    
    var ProfilePicImage:UIImage?{
        get{
            return _profilePicImage
        }
        set{
            _profilePicImage = newValue
        }
    }
    
    var ProfilePicUrl:String{
        get{
            return _profilePicUrl
        }
        set{
            _profilePicUrl = newValue
        }
    }

    
}
