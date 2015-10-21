import XCTest

class EndpointTests: XCTestCase {
  func testDynamicEndpointWithBadParams() {
    let params: Params = ["key": 1]
    let dynamicEndpoint = DynamicEndpoint(endpoint: .ActiveTeams, params: params)
    let path = dynamicEndpoint.path

    XCTAssertNil(path)
  }

  func testDynamicEndpointWithoutPathPart() {
    let params: Params = ["key": "value"]
    let dynamicEndpoint = DynamicEndpoint(endpoint: .ActiveTeams, params: params)
    let path = dynamicEndpoint.path

    XCTAssertNil(path)
  }

  func testDynamicEndpointWithPathPart() {
    let params: Params = ["week_id": "1"]
    let dynamicEndpoint = DynamicEndpoint(endpoint: .ActiveTeams, params: params)
    let path = dynamicEndpoint.path

    XCTAssertEqual(path, "/current_season/1/active_teams")
  }
}