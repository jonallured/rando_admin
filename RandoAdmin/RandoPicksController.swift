import UIKit

class RandoPicksController: UITableViewController {
    var rando: Rando!

    var picks: [Pick] {
        return rando.picks
    }

    @IBAction func unwindToRandoPicksController(sender: UIStoryboardSegue) {}

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let addRandoPickController = segue.destination as? AddRandoPickController else { return }
        addRandoPickController.rando = rando
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
