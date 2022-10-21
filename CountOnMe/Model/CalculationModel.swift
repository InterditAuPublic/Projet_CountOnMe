import Foundation

enum CustomError : Error {
    case error
    case error2
    
    public var errorDescription: String {
            switch self {
            case .error:
                return "I failed."
            case .error2:
                return "I failed again."
            }
        }
}

class CalculationModel {

    // MARK: Properties
    let operators = ["+","-","÷","x"]
    
    // MARK: Functions
    
    func canAddOperator(elements: [String]) -> Result<Void, CustomError>  {
        guard elements != [] else {
            return .failure(.error2)
        }
        if (!operators.contains(elements.last!)) {
            return .success(())
        } else {
            return .failure(.error2)
        }
    }
//    
//    func canAddOperator(elements: [String]) -> Bool {
//        return !operators.contains(elements.last!)
//    }
//    
    //Same as the previous one ?
    func expressionIsCorrect(elements: [String])  -> Bool {
        return !operators.contains(elements.last!)
    }

    func expressionHaveEnoughElement(elements: [String]) -> Bool {
        return elements.count >= 3
    }

    func expressionHaveResult(elements: [String]) -> Bool {
        return elements.contains("=")
    }

    func isDivideByZero(elements: [String]) -> Bool {
//        print(elements)
        if let index = elements.firstIndex(where: {$0 == "÷"}) {
            if elements[index + 1] == "0" {
                return true
            }
        }
        return false
    }

    // transform to result func
    func result(elements: [String]) -> String {

        //Copy elements to reduce them step by step
        var operationsToReduce = elements
        //While operationToReduce contains operant
        while operationsToReduce.count > 1 {

            guard var left = Double(operationsToReduce[0]) else { return "" }
            var operand = operationsToReduce[1]
            guard var right = Double(operationsToReduce[2]) else { return "" }

            let result: Double

            //Set index to 1
                var operandIndex = 1

                if let index = operationsToReduce.firstIndex(where: { $0 == "x" || $0 == "÷" }) {
                    operandIndex = index
                    if let leftunwrapp = Double(operationsToReduce[index - 1]) { left = leftunwrapp }
                    operand = operationsToReduce[index]
                    if let rightUnwrapp = Double(operationsToReduce[index + 1]) { right = rightUnwrapp }
                }
            result = calculate(left: Double(left), right: Double(right), operand: operand)
            
                for _ in 1...3 {
                    operationsToReduce.remove(at: operandIndex - 1)
                }
            operationsToReduce.insert(convertResult(result: Double(result)), at: operandIndex - 1 )

        }
            
        guard let finalResult = operationsToReduce.first else { return "" }
        return finalResult
    }

    func calculate(left: Double, right: Double, operand: String) -> Double {
        
        let result: Double

        switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "÷": result = left / right //Create divide func that verify divided by 0
            case "x": result = left * right
            default: return 0.0
        }
        return result
    }
    
    private func convertResult(result: Double) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 3
        guard let resultFormated = formatter.string(from: NSNumber(value: result)) else { return String() }
        return resultFormated
    }
}
