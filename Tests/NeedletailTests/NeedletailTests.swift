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
    
    func testTemplate() {
        let expectaion = XCTestExpectation(description: "Tempalte test")
        let queries = [URLQueryItem(name: "query1", value: "yes"),
                       URLQueryItem(name: "query2", value: "true")]
        let data = RequestData(templateParameters: ["template": "insert"])
        
        TemplateTestService.shared.request(TemplateTest.self, with: data) {
            XCTAssertNotNil($0)
            
            XCTAssertEqual($0!.test, "test")
            
            expectaion.fulfill()
        }
        
        wait(for: [expectaion], timeout: 10.0)
    }

    static var allTests = [
        ("testRequest", testRequest),
        ("testTemplate", testTemplate)
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

struct TemplateTest: Respondable {
    static var path: String = "/test/${template}"
    
    
    
    let test: String
}

final class TemplateTestService: Service {
    static var shared: TemplateTestService = TemplateTestService()

    
    var delimters: (left: String, right: String) = ("${", "}")
    
    private init() {}
    
    var baseURL: URL = "https://2ba868c7-a71b-4119-87f0-3f61c1ba5a69.mock.pstmn.io"
}
