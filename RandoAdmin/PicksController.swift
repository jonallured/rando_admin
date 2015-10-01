import UIKit

class PicksController: UITableViewController {
  var player: Player!

  var picks: [Pick] {
    return player.picks
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let pick = picks[indexPath.row]
    let cell = tableView.dequeueReusableCellWithIdentifier("Pick", forIndexPath: indexPath)
    cell.textLabel?.text = pick.week
    cell.detailTextLabel?.text = pick.teamName
    return cell
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return picks.count
  }
}