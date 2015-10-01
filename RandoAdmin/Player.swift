import Foundation

class Player {
  var id: Int
  var name: String
  var picks: [Pick]

  init(id: Int, name: String, picks: [Pick]) {
    (self.id, self.name, self.picks) = (id, name, picks)
  }
}
