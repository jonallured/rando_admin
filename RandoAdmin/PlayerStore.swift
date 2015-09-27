import Foundation

protocol PlayerStoreDelegate {
    func didUpdatePlayers()
}

class PlayerStore {
    var delegate: PlayerStoreDelegate?
    var players = [Player]()
    var router: Router
    
    init(router: Router = ApiRouter()) {
        self.router = router
    }
    
    func update() {
        router.get(.Players, completion: handleResponse)
    }
    
    func handleResponse(response: Response) {
        guard let json = response.json where response.isSuccess else { return }
        parseJSON(json)
        
        dispatch_async(dispatch_get_main_queue()) {
            self.delegate?.didUpdatePlayers()
        }
    }
    
    private func parseJSON(json: JSON) {
        if let playersJSON = json as? [[String: AnyObject]] {
            for playerJSON in playersJSON {
                if let id = playerJSON["id"] as? Int, let name = playerJSON["player_name"] as? String {
                    let player = Player(id: id, name: name)
                    players.append(player)
                }
            }
        }
    }
}