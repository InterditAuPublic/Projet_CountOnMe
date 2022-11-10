import XCTest
@testable import CountOnMe

class CountOnMeTests: XCTestCase {

    let model = CalculationModel()
    
    func test_canAddOperator_success()  {
        // Given
        let elements = ["12", "+", "8"]
        // When
        let canAddOperator = model.canAddOperator(elements: elements)
        // Then
        switch canAddOperator {
        case .success() : XCTAssertTrue(true)
        case .failure(_) : XCTFail("Erreur")
        }
       
    }
    
    func test_canAddOperator_fail()  {
        // Given
        let elements = ["12", "+", "8", "x"]
        // When
        let canAddOperator = model.canAddOperator(elements: elements)
        // Then
        switch canAddOperator {
        case .failure(_) : XCTAssertTrue(true)
        case .success() : XCTFail("Erreur")
        }
    }
    
    func test_expressionIsCorrect_true()  {
        // Given
        let elements = ["12", "+", "8"]
        // When
        let expression = model.expressionIsCorrect(elements: elements)
        // Then
        XCTAssertTrue(expression)
    }

    func test_expressionIsCorrect_false()  {
        // Given
        let elements = ["12", "+", "8","+"]
        // When
        let expression = model.expressionIsCorrect(elements: elements)
        // Then
        XCTAssertFalse(expression)
    }
    
    func test_expressionHaveEnoughElement_true() {
        // Given
        let elements = ["12", "+", "8"]
        // When
        let expression = model.expressionHaveEnoughElement(elements: elements)
        // Then
        XCTAssertTrue(expression)
    }
    
    func test_expressionHaveEnoughElement_false() {
        // Given
        let elements = ["12", "+"]
        // When
        let expression = model.expressionHaveEnoughElement(elements: elements)
        // Then
        XCTAssertFalse(expression)
    }

    func test_expressionHaveResult_true() {
        // Given
        let elements = ["12", "+", "8", "=", "20"]
        // When
        let expression = model.expressionHaveResult(elements: elements)
        // Then
        XCTAssertTrue(expression)
    }
    
    func test_expressionHaveResult_false() {
        // Given
        let elements = ["12", "+", "8"]
        // When
        let expression = model.expressionHaveResult(elements: elements)
        // Then
        XCTAssertFalse(expression)
    }
    
    func test_canProceed() {
        // Given
        let elements = ["12", "+", "8"]
        // When
        let canProceed = model.canProceed(elements: elements)
        // Then
        switch canProceed {
            case .success(_) : XCTAssertTrue(true)
            case .failure(_) : XCTFail(CustomError.newCalcul.errorDescription)
        }
    }
    
    func test_canProceed_incorrectExpression() {
        // Given
        let elements = ["12", "+", "8", "x"]
        // When
        let canProceed = model.canProceed(elements: elements)
        // Then
        switch canProceed {
            case .success(_) : XCTFail("Erreur, calcul done")
            case .failure(_) : XCTAssertTrue(true)
        }
    }
    
    func test_canProceed_notEnoughtElements() {
        // Given
        let elements = ["12"]
        // When
        let canProceed = model.canProceed(elements: elements)
        // Then
        switch canProceed {
            case .success(_) : XCTFail("Erreur, calcul done")
            case .failure(_) : XCTAssertTrue(true)
        }
    }
    
    func test_canProceed_alreadyHaveResult() {
        // Given
        let elements = ["12", "+", "8", "="]
        // When
        let canProceed = model.canProceed(elements: elements)
        // Then
        switch canProceed {
            case .success(_) : XCTFail("Erreur, calcul done")
            case .failure(_) : XCTAssertTrue(true)
        }
    }
    
    func test_calculateSoustraction() {
        // Given
        let a : Double = 2
        let b : Double = 3
        let o = "-"
        // When
        let results = model.calculate(left: a, right: b, operand: o)
        // Then
        switch results {
            case .success(let result) : XCTAssertEqual(a-b, result)
            case .failure(_) : XCTFail("Erreur, calcul done")
        }
    }
    
    func test_calculateAddition() {
        // Given
        let a : Double = 2
        let b : Double = 3
        let o = "+"
        // When
        let results = model.calculate(left: a, right: b, operand: o)
        // Then
        switch results {
            case .success(let result) : XCTAssertEqual(a+b, result)
            case .failure(_) : XCTFail("Erreur, calcul done")
        }
    }
    
    func test_calculateMultiplication() {
        // Given
        let a : Double = 2
        let b : Double = 3
        let o = "x"
        // When
        let results = model.calculate(left: a, right: b, operand: o)
        // Then
        switch results {
            case .success(let result) : XCTAssertEqual(a*b, result)
            case .failure(_) : XCTFail("Erreur, calcul done")
        }
    }
    
    func test_calculateDivide() {
        // Given
        let a : Double = 2
        let b : Double = 3
        let o = "÷"
        // When
        let results = model.calculate(left: a, right: b, operand: o)
        // Then
        switch results {
            case .success(let result) : XCTAssertEqual(a/b, result)
            case .failure(_) : XCTFail("Erreur, calcul done")
        }
    }
    
    func test_calculateDivideByZero() {
        // Given
        let a : Double = 2
        let b : Double = 0
        let o = "÷"
        // When
        let results = model.calculate(left: a, right: b, operand: o)
        // Then
        switch results {
            case .success(_) : XCTFail("Erreur, calcul done")
            case .failure(_) : XCTAssertTrue(true)
        }
    }
    
    func test_divide() {
        // Given
        let a : Double = 10
        let b : Double = 2
        // When
        let results = model.divide(left: a, right: b)
        // Then
        switch results {
            case .success(let result) : XCTAssertEqual(a/b, result)
            case .failure(_) : XCTFail("Une erreur est survenue")
        }
    }
    
    func test_divideBy0() {
        // Given
        let a : Double = 10
        let b : Double = 0
        // When
        let results = model.divide(left: a, right: b)
        // Then
        switch results {
            case .success(_) : XCTFail("Erreur, calcul done")
            case .failure(_) : XCTAssertTrue(true)
        }
    }
    
    func test_result_success() {
        // Given
        let elements = ["12", "+", "8", "x", "4", "-", "5"]
        let result = "39"
        // When
        let results = model.result(elements: elements)
        // Then
        switch results {
            case .success(let finalResult) : XCTAssertTrue(result == finalResult)
            case .failure(_) : XCTFail("Erreur while computing")
        }
    }
    
    func test_convertResult() {
        // Given
        let resultToConvert = 10.1111111
        let convertedResult = "10.111"
        // When
        let result = model.convertResult(result: resultToConvert)
        // Then
        XCTAssertTrue(result == convertedResult)
    }
    
    func test_result_failed_notEnoughtElements() {
        // Given
        let elements = ["12"]
        // When
        let results = model.result(elements: elements)
        // Then
        switch results {
            case .success(_) : XCTFail("Error calcul done!")
            case .failure(_) : XCTAssertTrue(true)
        }
    }
}
