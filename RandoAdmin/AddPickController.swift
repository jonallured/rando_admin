import UIKit

class AddPickController: UIViewController {
  let builder = PickBuilder()
  var player: Player!

  var teams: [Team] {
    return TeamStore.sharedInstance.teams
  }

  @IBOutlet weak var tableView: UITableView!

  @IBAction func saveButtonPressed(sender: AnyObject) {
    guard let indexPath = tableView.indexPathForSelectedRow else { return }
    let team = teams[indexPath.row]
    builder.create(player, team: team)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    builder.delegate = self
  }
}

extension AddPickController: UITableViewDataSource {
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Team", forIndexPath: indexPath)
    cell.textLabel?.text = teams[indexPath.row].name
    return cell
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return teams.count
  }
}

extension AddPickController: UITableViewDelegate {}

extension AddPickController: PickBuilderDelegate {
  func didFinishCreating(picks: [Pick]) {
    player.picks = picks
    dismissViewControllerAnimated(true, completion: nil)
  }
}
