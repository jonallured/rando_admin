import Foundation

typealias Params = [String: AnyObject]

class Request {
  var path: String
  var completion: (Response) -> Void

  class func get(path: String, completion: (Response) -> Void) {
    let request = Request(path: path, completion: completion)
    request.get()
  }

  class func post(path: String, params: Params, completion: (Response) -> Void) {
    let pathWithParams = path + params
    let request = Request(path: pathWithParams, completion: completion)
    request.post()
  }

  init(path: String, completion: (Response) -> Void) {
    (self.path, self.completion) = (path, completion)
  }

  func get() {
    guard let url = NSURL(string: path) else { return }
    let request = NSURLRequest(URL: url)
    NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: handler).resume()
  }

  func post() {
    guard let url = NSURL(string: path) else { return }
    let request = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "POST"
    NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: handler).resume()
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