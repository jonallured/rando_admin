import XCTest

class PickAttributesTests: XCTestCase {
  func testWithBadJSON() {
    let json: JSON = 0
    let attrs = PickAttributes.fromJSON(json)

    XCTAssertEqual(attrs.count, 0)
  }

  func testWithEmptyJSON() {
    let json = [JSON]()
    let attrs = PickAttributes.fromJSON(json)

    XCTAssertEqual(attrs.count, 0)
  }

  func testWithBadKeys() {
    let json: [JSON] = [[ "key": "value" ]]
    let attrs = PickAttributes.fromJSON(json)

    XCTAssertEqual(attrs.count, 0)
  }

  func testWithGoodKeys() {
    let json: [JSON] = [[
      "week_number": 1,
      "team_id": 1
      ]]

    let attrs = PickAttributes.fromJSON(json)

    XCTAssertEqual(attrs.count, 1)

    let pickAttrs = attrs.first
    XCTAssertEqual(pickAttrs?.weekNumber, 1)
    XCTAssertEqual(pickAttrs?.teamId, 1)
  }
}
