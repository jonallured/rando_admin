import UIKit

class RandoPicksController: UITableViewController {
  var rando: Rando!

  var picks: [Pick] {
    return rando.picks
  }

  @IBAction func unwindToRandoPicksController(sender: UIStoryboardSegue) {}

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    guard let addRandoPickController = segue.destinationViewController as? AddRandoPickController else { return }
    addRandoPickController.rando = rando
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
