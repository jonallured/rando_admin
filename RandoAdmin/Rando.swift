import Foundation

protocol RandoDelegate {
    func didUpdateRando()
}

class Rando {
    var delegate: RandoDelegate?
    var picks = [Pick]()
    var router: Router

    var nextWeekNumber: Int {
        return picks.count + 1
    }

    init(router: Router = ApiRouter.instance) {
        self.router = router
    }

    func update() {
//        router.get(.RandoPicks, params: [:], completion: handleResponse)
    }

    func handleResponse(response: Response) {
        guard response.isSuccess, let json = response.json else { return }

        let attributes = PickAttributes.fromJSON(json: json)
        picks = attributes.map { Pick($0) }

        DispatchQueue.main.async {
            self.delegate?.didUpdateRando()
        }
    }
}
