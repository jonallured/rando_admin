import Foundation

struct ApiRouter {
    static var instance: Router {
        return ProductionRouter()
    }
}

class ProductionRouter: Router {
    func get(endpoint: Endpoint, params: Params, completion: (Response) -> Void) {
        //
    }

    func get(path: String, params: Params, completion: (Response) -> Void) {
        //
    }

    func post(endpoint: Endpoint, params: Params, completion: (Response) -> Void) {
        //
    }

    func post(path: String, params: Params, completion: (Response) -> Void) {
        //
    }

    var baseURL = "https://rando-pool.herokuapp.com/api"

//    func get(endpoint: Endpoint, params: Params, completion: @escaping (Response) -> Void) {
//        get(path: endpoint.rawValue, params: params, completion: completion)
//    }
//
//    func get(path: String, params: Params, completion: @escaping (Response) -> Void) {
//        let path = baseURL + path
//        Request.get(path: path, params: params, completion: completion)
//    }
//
//    func post(endpoint: Endpoint, params: Params, completion: @escaping (Response) -> Void) {
//        post(path: endpoint.rawValue, params: params, completion: completion)
//    }
//
//    func post(path: String, params: Params, completion: @escaping (Response) -> Void) {
//        let path = baseURL + path
//        Request.post(path: path, params: params, completion: completion)
//    }
}
