import Foundation

typealias JSON = AnyObject

class Response {
    var code: Int?
    var json: JSON?
    
    var isSuccess: Bool {
        return code == 200
    }
    
    init(code: Int?, json: JSON?) {
        (self.code, self.json) = (code, json)
    }
}