import XCTest
@testable import CountOnMe

class CalculationModelTests: XCTestCase {

    let model = CalculationModel()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_addition() {
        //given
        let a = 2
        let b = 3
        //when
        let result = model.addition(a: a, b: b)
        //then
        XCTAssertEqual(a+b, result)
    }

}
