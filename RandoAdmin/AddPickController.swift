import UIKit

class AddPickController: UIViewController {
  let builder = PickBuilder()
  var player: Player!
  var selectedTeam: Team?

  var teams: [Team] {
    return TeamStore.sharedInstance.teams
  }

  @IBOutlet weak var tableView: UITableView!

  @IBAction func saveButtonPressed(sender: AnyObject) {
    guard let team = selectedTeam else { return }
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
    let team = teams[indexPath.row]
    cell.textLabel?.text = team.name

    if let selectedTeam = selectedTeam {
      cell.accessoryType = team == selectedTeam ? .Checkmark : .None
    }

    let selectedView = UIView()
    selectedView.backgroundColor = UIColor.darkGrayColor()
    cell.selectedBackgroundView = selectedView

    return cell
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return teams.count
  }
}

extension AddPickController: UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    var indexPaths = [indexPath]

    if let
      selectedTeam = selectedTeam,
      selectedIndex = teams.indexOf(selectedTeam) {
        indexPaths.append(NSIndexPath(forRow: selectedIndex, inSection: 0))
    }

    selectedTeam = teams[indexPath.row]

    tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    tableView.selectRowAtIndexPath(nil, animated: true, scrollPosition: .None)
  }
}

extension AddPickController: PickBuilderDelegate {
  func didFinishCreating(picks: [Pick]) {
    player.picks = picks
    dismissViewControllerAnimated(true, completion: nil)
  }
}
