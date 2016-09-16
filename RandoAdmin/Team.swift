import Foundation

class Team: Comparable {
  var id: Int
  var name: String

  init(id: Int, name: String) {
    (self.id, self.name) = (id, name)
  }
}

func <(lhs: Team, rhs: Team) -> Bool {
  return lhs.name < rhs.name
}

func ==(lhs: Team, rhs: Team) -> Bool {
  return lhs.id == rhs.id
}