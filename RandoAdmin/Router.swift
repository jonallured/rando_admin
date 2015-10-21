import Foundation

protocol Router {
  func get(endpoint: Endpoint, params: Params, completion: (Response) -> Void)
  func get(path: String, params: Params, completion: (Response) -> Void)
  func post(endpoint: Endpoint, params: Params, completion: (Response) -> Void)
  func post(path: String, params: Params, completion: (Response) -> Void)
}
