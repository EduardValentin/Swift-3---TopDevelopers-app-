//
//  UserData.swift
//  TopDevelopers
//
//  Created by Eduard Valentin on 14/04/2018.
//  Copyright © 2018 Eduard Valentin. All rights reserved.
//

import Foundation

class UserData: NSObject,NSCoding {
    
    struct Keys{
        static let Data = "data"
    }
    
    private var _users : [User] = []
    
    override init() {}
    
    init(with data: [User]) {
        _users = data
    }
    
    required init?(coder aDecoder: NSCoder) {
        if let userObj = aDecoder.decodeObject(forKey: Keys.Data) as? [User] {
            _users = userObj
        }
        
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(_users, forKey: Keys.Data)
    }
    
    var SavedData : [User] {
        get {
            return _users
        }
        set {
            _users = newValue
        }
    }
    
    func appendUser(newUser: User) {
        _users.append(newUser)
    }
    
    func numberOfUsers() -> Int {
        return _users.count
    }
    
    func userAtIndex(index: Int) -> User? {
        if(index < _users.count) {
            return _users[index]
        } else {
            print("Error in userAtINdex(() index to big")
            return nil
        }
    }
}
