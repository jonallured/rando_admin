import Foundation

class Player {
  var id: Int
  var name: String
  var out: Bool
  var picks: [Pick]

  var nextWeekNumber: Int {
    return picks.count + 1
  }

  init(id: Int, name: String, out: Bool, picks: [Pick]) {
    (self.id, self.name, self.out, self.picks) = (id, name, out, picks)
  }

  convenience init(_ attributes: PlayerAttributes) {
    self.init(id: attributes.id, name: attributes.name, out: attributes.out, picks: attributes.picks)
  }
}
