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

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    if let indexPath = tableView.indexPathForSelectedRow {
      tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Player", forIndexPath: indexPath)
    cell.textLabel?.text = players[indexPath.row].name

    let selectedView = UIView()
    selectedView.backgroundColor = UIColor.darkGrayColor()
    cell.selectedBackgroundView = selectedView

    return cell
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return players.count
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    guard let
      picksController = segue.destinationViewController as? PicksController,
      indexPath = tableView.indexPathForSelectedRow
      where segue.id == .ShowPicks else { return }

    let player = players[indexPath.row]
    picksController.player = player
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
