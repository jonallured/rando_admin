import UIKit

class PlayersController: UITableViewController {
    let store = PlayerStore()
    
    var players: [Player] {
        return store.players
    }
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
        store.delegate = self
        store.update()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Player", forIndexPath: indexPath)
        cell.textLabel?.text = players[indexPath.row].name
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
}

extension PlayersController: PlayerStoreDelegate {
    func didUpdatePlayers() {
        tableView.reloadData()
    }
}