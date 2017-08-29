import UIKit

class PicksController: UITableViewController {
    var player: Player!

    var picks: [Pick] {
        return player.picks
    }

    @IBAction func unwindToPicksController(sender: UIStoryboardSegue) {}

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.id == .AddPick, let addPickController = segue.destination as? AddPickController else { return }
        addPickController.player = player
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pick = picks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Pick", for: indexPath)
        cell.textLabel?.text = pick.week
        cell.detailTextLabel?.text = pick.teamName
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return picks.count
    }
}
