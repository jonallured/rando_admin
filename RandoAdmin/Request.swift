import Foundation

typealias Params = [String: AnyObject]

class Request {
    let path: String
    let method: String
    let completion: (Response) -> Void

    var task: URLSessionDataTask {
        let url = URL(string: path)!
        var request = URLRequest(url: url)
        request.httpMethod = method
        return URLSession.shared.dataTask(with: request, completionHandler: handler)
    }

    class func get(path: String, params: Params = [:], completion: @escaping (Response) -> Void) {
        let request = Request(path: path, params: params, method: "GET", completion: completion)
        request.resumeTask()
    }

    class func post(path: String, params: Params, completion: @escaping (Response) -> Void) {
        let request = Request(path: path, params: params, method: "POST", completion: completion)
        request.resumeTask()
    }

    init(path: String, params: Params, method: String, completion: @escaping (Response) -> Void) {
        self.path = path + params
        self.method = method
        self.completion = completion
    }

    func resumeTask() {
        task.resume()
    }

    func handler(data: Data?, response: URLResponse?, error: Error?) {
        var code: Int?
        var json: JSON?

        if let httpResponse = response as? HTTPURLResponse {
            code = httpResponse.statusCode
        }

        if let data = data {
//            json = try? JSONSerialization.JSONObjectWithData(data, options: [])
        }

        completion(Response(code: code, json: json))
    }
}

private func +(path: String, params: Params) -> String {
    let paramString = params.map({"\($0.0)=\(String(describing: $0.1))"}).joined(separator: "&")
    return "\(path)?\(paramString)"
}
