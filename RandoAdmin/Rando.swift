import Foundation

protocol RandoDelegate {
  func didUpdateRando()
}

class Rando {
  var delegate: RandoDelegate?
  var picks = [Pick]()
  var router: Router

  init(router: Router = ApiRouter.instance) {
    self.router = router
  }

  func update() {
    router.get(.RandoPicks, completion: handleResponse)
  }

  func handleResponse(response: Response) {
    guard let json = response.json where response.isSuccess else { return }

    let attributes = PickAttributes.fromJSON(json)
    picks = attributes.map { Pick($0) }

    dispatch_async(dispatch_get_main_queue()) {
      self.delegate?.didUpdateRando()
    }
  }
}
