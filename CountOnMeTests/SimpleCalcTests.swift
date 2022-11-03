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
    
    func test_canAddOperator()  {
       
    }
    
    func test_expressionIsCorrect()  {
        
    }

    func test_expressionHaveEnoughElement() {
        
    }

    func test_expressionHaveResult() {
        
    }
    
    func test_canProceed_false() {
        let elements = ["12", "+", "8", "x"]
        
        let canProceed = model.canProceed(elements: elements)
    }
    
    func test_canProceed_true() {
        let elements = ["12", "+", "8", "x", "4"]
        
        let canProceed = model.canProceed(elements: elements)
        
    }
    
    func test_soustraction() {
        //given
        let a : Double = 2
        let b : Double = 3
        let o = "-"
        //when
        let results = model.calculate(left: a, right: b, operand: o)
        //then
//        XCTAssertEqual(a+b, results)
    }
    
    func test_addition() {
        //given
        let a : Double = 2
        let b : Double = 3
        let o = "+"
        //when
        let result = model.calculate(left: a, right: b, operand: o)
        //then
//        XCTAssertEqual(a+b, result)
    }
    
    func test_multiplication() {
        //given
        let a : Double = 2
        let b : Double = 3
        let o = "x"
        //when
        let result = model.calculate(left: a, right: b, operand: o)
        //then
        
    }
    
    func test_divide() {
        //given
        let a : Double = 2
        let b : Double = 3
        let o = "÷"
        //when
        let result = model.calculate(left: a, right: b, operand: o)
        //then
    }
    
    func test_divideByZero() {
        //given
        let a : Double = 2
        let b : Double = 0
        let o = "÷"
        //when
        let result = model.calculate(left: a, right: b, operand: o)
        //then
    }
    
    func test_result() {
        let elements = ["12", "+", "8", "x", "4"]
    }
    
    func test_calculate() {
        
    }
    
    func convertResult() {
        let resultToConvert = 10.1111111
        
        let result = model.convertResult(result: resultToConvert)
    }
}
