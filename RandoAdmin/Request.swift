import Foundation

typealias Params = [String: AnyObject]

class Request {
  let path: String
  let method: String
  let completion: (Response) -> Void

  var task: NSURLSessionDataTask {
    let url = NSURL(string: path)!
    let request = NSMutableURLRequest(URL: url)
    request.HTTPMethod = method
    return NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: handler)
  }

  class func get(path: String, params: Params = [:], completion: (Response) -> Void) {
    let request = Request(path: path, params: params, method: "GET", completion: completion)
    request.resumeTask()
  }

  class func post(path: String, params: Params, completion: (Response) -> Void) {
    let request = Request(path: path, params: params, method: "POST", completion: completion)
    request.resumeTask()
  }

  init(path: String, params: Params, method: String, completion: (Response) -> Void) {
    self.path = path + params
    (self.method, self.completion) = (method, completion)
  }

  func resumeTask() {
    task.resume()
  }

  func handler(data: NSData?, response: NSURLResponse?, error: NSError?) {
    var code: Int?
    var json: JSON?

    if let httpResponse = response as? NSHTTPURLResponse {
      code = httpResponse.statusCode
    }

    if let data = data {
      json = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
    }

    completion(Response(code: code, json: json))
  }
}

private func +(path: String, params: Params) -> String {
  let paramString = params.map({"\($0.0)=\(String($0.1))"}).joinWithSeparator("&")
  return "\(path)?\(paramString)"
}
