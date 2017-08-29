import Foundation

protocol PlayerStoreDelegate {
    func didUpdatePlayers()
}

class PlayerStore {
    var delegate: PlayerStoreDelegate?
    var players = [Player]()

    func update() {
        Router.hit(.players, handler: handleResponse)
    }

    private func handleResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            else { return }

        let attributes = PlayerAttributes.fromJSON(json: json)
        players = attributes.map { Player($0) }.sorted()

        DispatchQueue.main.async {
            self.delegate?.didUpdatePlayers()
        }
    }
}
