import UIKit

class PlayersController: UITableViewController {
  var store: PlayerStore! {
    didSet {
      store.delegate = self
    }
  }

  var players: [Player] {
    return store.players
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    refreshControl?.addTarget(self, action: "refreshPlayers", forControlEvents: .ValueChanged)
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