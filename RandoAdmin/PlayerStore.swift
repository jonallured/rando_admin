import Foundation

protocol PlayerStoreDelegate {
    func didUpdatePlayers()
}

class PlayerStore {
    var delegate: PlayerStoreDelegate?
    var players = [Player]()
    
    func update() {
        let path = "https://rando-pool.herokuapp.com/api/current_characters"
        guard let url = NSURL(string: path) else { return }
        let request = NSURLRequest(URL: url)
        NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: parseData).resume()
    }
    
    func parseData(data: NSData?, response: NSURLResponse?, error: NSError?) {
        do {
            guard let data = data else { print("OMG"); return }
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            
            if let playersJSON = json as? [[String: AnyObject]] {
                for playerJSON in playersJSON {
                    if let id = playerJSON["id"] as? Int, let name = playerJSON["player_name"] as? String {
                        let player = Player(id: id, name: name)
                        players.append(player)
                    }
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.delegate?.didUpdatePlayers()
                }
            }
        } catch {
            print(error)
        }
        
    }
}