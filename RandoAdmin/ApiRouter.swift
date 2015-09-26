import Foundation

protocol Router {
    func get(endpoint: Endpoint, completion: (Response) -> Void)
}

class ApiRouter: Router {
    var baseURL = "https://rando-pool.herokuapp.com/api"
    
    func get(endpoint: Endpoint, completion: (Response) -> Void) {
        let path = baseURL + endpoint.rawValue
        Request.get(path, completion: completion)
    }
}