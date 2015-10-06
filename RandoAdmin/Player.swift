import Foundation

class Player {
  var id: Int
  var name: String
  var picks: [Pick]

  var nextWeekNumber: Int {
    return picks.count + 1
  }

  init(id: Int, name: String, picks: [Pick]) {
    (self.id, self.name, self.picks) = (id, name, picks)
  }
}
