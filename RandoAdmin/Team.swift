import Foundation

class Team {
  var id: Int
  var name: String

  init(id: Int, name: String) {
    (self.id, self.name) = (id, name)
  }
}