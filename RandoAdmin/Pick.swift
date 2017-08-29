import Foundation

class Pick {
  var week: String
  var team: Team

  var teamName: String {
    return team.name
  }

  init(weekNumber: Int, teamId: Int) {
    self.week = "Week \(weekNumber)"
    self.team = TeamStore.withId(id: teamId)
  }

  convenience init(_ attributes: PickAttributes) {
    self.init(weekNumber: attributes.weekNumber, teamId: attributes.teamId)
  }
}
