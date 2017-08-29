import Foundation

protocol RandoDelegate {
    func didUpdateRando()
}

class Rando {
    var delegate: RandoDelegate?
    var picks = [Pick]()

    var nextWeekNumber: Int {
        return picks.count + 1
    }

    func update() {
        Router.hit(.listRandoPicks, handler: handleResponse)
    }

    private func handleResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            else { return }

        let attributes = PickAttributes.fromJSON(json: json)
        picks = attributes.map { Pick($0) }

        DispatchQueue.main.async {
            self.delegate?.didUpdateRando()
        }
    }
}
