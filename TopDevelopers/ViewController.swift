import UIKit
import Alamofire
import Foundation


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    private var userData = UserData()
    private var clearMemoryTimer = Timer.scheduledTimer(timeInterval: 30.0*60.0, target: self, selector: #selector(clearMemory), userInfo: nil, repeats: true)
    private let ramCache = NSCache<NSString,UserData>()
    
    
    let param: Parameters = [
        "order": "desc",
        "max" : 10,
        "sort" : "reputation",
        "site" : "stackoverflow"
    ]

    private var filePath:String{
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        return url!.appendingPathComponent("SavedData").path
    }

    
    override func viewDidLoad() {
    print("view loaded")
        
        super.viewDidLoad()
        self.loadData()

        tableView.delegate = self
        tableView.dataSource = self
        
        let nibName = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "tableViewCell")
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userData.numberOfUsers()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! CustomTableViewCell
       
        cell.commonInit(image: self.userData.userAtIndex(index: indexPath.item)!.ProfilePicImage!, labelText: self.userData.userAtIndex(index: indexPath.item)!.Username)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailsUserViewController()
        detailViewController.commonInit(image: self.userData.userAtIndex(index: indexPath.item)!.ProfilePicImage!,
                                        name: self.userData.userAtIndex(index: indexPath.item)!.Username,
                                        location: self.userData.userAtIndex(index: indexPath.item)!.Location,
                                        bronzeBadges: self.userData.userAtIndex(index: indexPath.item)!.BronzeBadges,
                                        silverBadges: self.userData.userAtIndex(index: indexPath.item)!.SilverBadges,
                                        goldBadges: self.userData.userAtIndex(index: indexPath.item)!.GoldBadges)
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func saveData(user: User) {
        self.userData.appendUser(newUser: user)
        NSKeyedArchiver.archiveRootObject(userData, toFile: filePath)  // we save on disk
        ramCache.setObject(self.userData, forKey: "Data" )
    }
    
    private func loadData() {
        if let cachedUsers = self.ramCache.object(forKey: "Data" ) {
            print("data was on ram")
            self.userData.SavedData = cachedUsers.SavedData
            
        }
        else if let savedUsers = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? UserData {
            // check if its on disk
            print("data was on disk")
            self.userData.SavedData = savedUsers.SavedData
            ramCache.setObject(self.userData, forKey: "Data")
        } else {
            print("we requested the data")
            self.requestDataFromApi()
        }
    }
    
    func clearMemory()
    {
        do{
            try FileManager.default.removeItem(atPath: filePath)
        }
        catch{
            print("Error in clearMemory()")
        }
    }
    
    
    
    private func requestDataFromApi() {
        // GET the data from the stackexchange api
        
        
        
        Alamofire.request("https://api.stackexchange.com/2.2/users", method: .get, parameters: param).responseJSON { (response) -> (Void) in
            
            if let json = response.result.value {
                // we got a result
                
                /* I know this is a bit ugly */
                let json1 = json as! [String:AnyObject]
                let usersInfoFromJSON = json1["items"] as! NSArray       // remember to cast it as NSDictionary
                
                
                for userInfo in usersInfoFromJSON {
                    
                    let userDict = userInfo as! NSDictionary
                    
                    // download user image from url
                    
                    Alamofire.request(userDict["profile_image"] as! String).responseData { (response) in
                        if response.error == nil {
                            
                            //print(response.result)
                            
                            if let data = response.data {
                                
                                // save the downloaded image
                                
                                let imageView = UIImageView()
                                imageView.image = UIImage(data: data)
                                
                                // check if user has location set, if not display a proper message
                                var userLocation:String=""
                                
                                if let checkLocation = (userDict["location"] as? String) {
                                    userLocation = checkLocation
                                } else {
                                    userLocation = "Location is not set."
                                }
                                
                                // get every badge count from the json to use it in User constructor
                                
                                let badgeCounts = userDict["badge_counts"] as? [String:Int]
                                
                                var goldb = 0
                                var bronzeb = 0
                                var silverb = 0
                                
                                if badgeCounts != nil {
                                    bronzeb = badgeCounts!["bronze"]!
                                    silverb = badgeCounts!["silver"]!
                                    goldb   =   badgeCounts!["gold"]!
                                }
                                
                                
                                let newUser = User(username: userDict["display_name"] as! String,
                                                   location: userLocation,
                                                   bronzeBadges: bronzeb,
                                                   silverBadges: silverb,
                                                   goldBadges: goldb,
                                                   profilePicUrl: userDict["profile_image"] as! String,
                                                   profilePicImg: imageView.image)
                                
                                self.saveData(user: newUser)
                                
                                self.tableView.reloadData()
                                
                            }
                        }
                    } // end alamofire second request
                } // end user iteration
            }
        } // end alamofire first request
    }


}
