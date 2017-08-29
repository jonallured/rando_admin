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
        builder.create(player: player, team: team)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        builder.delegate = self
    }
}

extension AddPickController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Team", for: indexPath)
        let team = teams[indexPath.row]
        cell.textLabel?.text = team.name


        if let selectedTeam = selectedTeam {
            cell.accessoryType = team == selectedTeam ? .checkmark : .none
        }

        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.darkGray
        cell.selectedBackgroundView = selectedView

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
}

extension AddPickController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var indexPaths = [indexPath]

        if let selectedTeam = selectedTeam, let selectedIndex = teams.index(of: selectedTeam) {
            indexPaths.append(IndexPath(row: selectedIndex, section: 0))
        }

        selectedTeam = teams[indexPath.row]

        tableView.reloadRows(at: indexPaths, with: .automatic)
        tableView.selectRow(at: nil, animated: true, scrollPosition: .none)
    }
}

extension AddPickController: PickBuilderDelegate {
    func didFinishCreating(picks: [Pick]) {
        player.picks = picks
        dismiss(animated: true, completion: nil)
    }
}
