import XCTest
@testable import Needletail

final class NeedletailTests: XCTestCase {
    func testRequest() {
        let expectaion = XCTestExpectation(description: "Simple Day of Year Test")
        
        TimeService.shared.request(Time.self) { (time) in
            guard let dayOfYear = Calendar.current.ordinality(of: .day, in: .year, for: Date()),
            let time = time else {
                XCTFail(); return
            }
            
            XCTAssert(time.day_of_year == dayOfYear + 1)
            
            expectaion.fulfill()
        }
        
        wait(for: [expectaion], timeout: 10.0)
    }

    static var allTests = [
        ("testRequest", testRequest),
    ]
}


struct Time: Respondable {
    static var path: String = "/api/timezone/America/Argentina/Salta"
    
    let day_of_year: Int
}

final class TimeService: Service {
    static var shared: TimeService = TimeService()
    
    private init() {}
    
    var baseURL: URL = "http://worldtimeapi.org"
}
