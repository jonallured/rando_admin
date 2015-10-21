import XCTest

class DynamicEndpointTests: XCTestCase {
  func testBadParams() {
    let params: Params = ["key": 1]
    let dynamicEndpoint = DynamicEndpoint(endpoint: .ActiveTeams, params: params)
    let path = dynamicEndpoint.path

    XCTAssertNil(path)
  }

  func testWithoutPathPart() {
    let params: Params = ["key": "value"]
    let dynamicEndpoint = DynamicEndpoint(endpoint: .ActiveTeams, params: params)
    let path = dynamicEndpoint.path

    XCTAssertNil(path)
  }

  func testWithPathPart() {
    let params: Params = ["week_number": "1"]
    let dynamicEndpoint = DynamicEndpoint(endpoint: .ActiveTeams, params: params)
    let path = dynamicEndpoint.path

    XCTAssertEqual(path, "/current_season/weeks/1/active_teams")
  }
}
