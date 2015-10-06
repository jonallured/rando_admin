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

  class func get(path: String, completion: (Response) -> Void) {
    let request = Request(path: path, method: "GET", completion: completion)
    request.resumeTask()
  }

  class func post(path: String, params: Params, completion: (Response) -> Void) {
    let pathWithParams = path + params
    let request = Request(path: pathWithParams, method: "POST", completion: completion)
    request.resumeTask()
  }

  init(path: String, method: String, completion: (Response) -> Void) {
    (self.path, self.method, self.completion) = (path, method, completion)
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
      do {
        json = try NSJSONSerialization.JSONObjectWithData(data, options: [])
      } catch {
        // not sure what to do here...
      }
    }

    completion(Response(code: code, json: json))
  }
}

private func +(path: String, params: Params) -> String {
  let paramString = params.map({"\($0.0)=\(String($0.1))"}).joinWithSeparator("&")
  return "\(path)?\(paramString)"
}