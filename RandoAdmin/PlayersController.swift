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
        // this still seems wrong...
        refreshControl?.addTarget(self, action: "refreshPlayers", for: .valueChanged)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Player", for: indexPath)
        let player = players[indexPath.row]
        let attributes = [
            NSAttributedStringKey.strikethroughStyle: player.out
        ]
        let playerName = NSAttributedString(string: player.name, attributes: attributes)
        cell.textLabel?.attributedText = playerName

        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.darkGray
        cell.selectedBackgroundView = selectedView

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.id == .ShowPicks,
            let picksController = segue.destination as? PicksController,
            let indexPath = tableView.indexPathForSelectedRow
            else { return }

        let player = players[indexPath.row]
        picksController.player = player
    }

    func refreshPlayers() {
        store.update()
    }
}

extension PlayersController: PlayerStoreDelegate {
    func didUpdatePlayers() {
        if let refresh = refreshControl, refresh.isRefreshing {
            refresh.endRefreshing()
        }

        tableView.reloadData()
    }
}
