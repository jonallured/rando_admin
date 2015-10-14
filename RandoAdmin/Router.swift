import Foundation

protocol Router {
  func get(endpoint: Endpoint, completion: (Response) -> Void)
  func post(endpoint: Endpoint, params: Params, completion: (Response) -> Void)
}
