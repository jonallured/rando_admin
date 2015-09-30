import UIKit

class PlayersController: UITableViewController {
  let store = PlayerStore()

  var players: [Player] {
    return store.players
  }

  override func viewDidLoad() {
    store.delegate = self
    refreshControl?.addTarget(self, action: "refreshPlayers", forControlEvents: .ValueChanged)
    refreshPlayers()
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Player", forIndexPath: indexPath)
    cell.textLabel?.text = players[indexPath.row].name
    return cell
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return players.count
  }

  func refreshPlayers() {
    store.update()
  }
}

extension PlayersController: PlayerStoreDelegate {
  func didUpdatePlayers() {
    if let refresh = refreshControl where refresh.refreshing {
      refresh.endRefreshing()
    }

    tableView.reloadData()
  }
}