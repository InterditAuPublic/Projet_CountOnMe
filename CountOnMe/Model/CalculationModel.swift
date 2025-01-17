import Foundation

enum CustomError : Error {
    case error
    case whileComputing
    case numberIsRequired
    case expressionIsIncorrect
    case divideByZero
    case newCalcul
    case cannotAddOperator
    case cannotAddDot
    
    public var errorDescription: String {
            switch self {
            case .error:
                return "Erreur."
            case .whileComputing:
                return "Erreur lors du calcul"
            case .numberIsRequired:
                return "Vous devez saisir des nombres !"
            case .cannotAddOperator:
                return "Impossible d'ajouter un operateur"
            case .cannotAddDot:
                return "Impossible d'ajouter une vigule"
            case .expressionIsIncorrect:
                return "Impossible de terminer le calcul par un operateur"
            case .divideByZero:
                return "Division par 0 !"
            case .newCalcul:
                return "Demarrer un nouveau calcul !"
        }
    }
}

class CalculationModel {

    // MARK: Properties
    let operators = ["+","-","÷","x", "."]
    
    // MARK: Functions
    
//  Fonction that check if user can add an operator
    func canAddOperator(elements: [String]) -> Result<Void, CustomError>  {
        guard elements != [] else {
            return .failure(.cannotAddOperator)
        }
        if (!operators.contains(elements.last!)) {
            return .success(())
        } else {
            return .failure(.cannotAddOperator)
        }
    }
    
    //  Fonction that check if user can add dot to the number
    func canAddDots(elements: [String]) -> Result<Void, CustomError>  {
        guard elements != [] else {
            return .failure(.cannotAddDot)
        }
        if (!operators.contains(elements.last!)) {
            let number = elements.last?.components(separatedBy: ".")
            if number!.count > 1 {
                return .failure(.cannotAddDot)
            }
            return .success(())
        } else {
            return .failure(.cannotAddDot)
        }
    }

    // Check is elements doesn't finish with an operator
    func expressionIsCorrect(elements: [String])  -> Bool {
        return !operators.contains(elements.last!)
    }

    // Check if [elements] contains more than 2 elements
    func expressionHaveEnoughElement(elements: [String]) -> Bool {
        return elements.count >= 3
    }

    // Check if the calcul a previous result
    func expressionHaveResult(elements: [String]) -> Bool {
        return elements.contains("=")
    }
    
    // Check if the calcul can be proceed
    func canProceed(elements: [String]) -> Result<Bool, CustomError> {
        guard !expressionHaveResult(elements: elements) else {
            return .failure(.newCalcul)
        }
        guard expressionHaveEnoughElement(elements: elements) else {
            return .failure(.numberIsRequired)
        }
        guard expressionIsCorrect(elements: elements) else {
            return .failure(.expressionIsIncorrect)
        }
        return .success(true)
    }

//   Function that return result of the calcul
    func result(elements: [String]) -> Result<String, CustomError> {
//        check if the elements of the array can be proccedde
        switch canProceed(elements: elements) {
        case .failure(let errorType) :
            return .failure(errorType)
        case .success(_): break
        }
        //Copy elements to reduce them step by step
        var operationsToReduce = elements
        //While operationToReduce contains operant
        while operationsToReduce.count > 1 {
            guard var left = Double(operationsToReduce[0]) else { return .failure(.error) }
            var operand = operationsToReduce[1]
            guard var right = Double(operationsToReduce[2]) else { return .failure(.error) }
            //Set index to 1
                var operandIndex = 1
                if let index = operationsToReduce.firstIndex(where: { $0 == "x" || $0 == "÷" }) {
                    operandIndex = index
                    if let leftunwrapp = Double(operationsToReduce[index - 1]) { left = leftunwrapp }
                    operand = operationsToReduce[index]
                    if let rightUnwrapp = Double(operationsToReduce[index + 1]) { right = rightUnwrapp }
                }
            switch calculate(left: Double(left), right: Double(right), operand: operand) {
            case .success(let result):
                for _ in 1...3 {
                    operationsToReduce.remove(at: operandIndex - 1)
                }
                operationsToReduce.insert(convertResult(result: Double(result)), at: operandIndex - 1 )
            case .failure(let errorType) :
                return .failure(errorType)
            }
        }
        guard let finalResult = operationsToReduce.first else { return .failure(.whileComputing) }
        return .success(finalResult)
    }

//    calculate function, takes left, right, operant, then procced to the calcul
    func calculate(left: Double, right: Double, operand: String) -> Result<Double, CustomError> {
        
        let result: Double
        switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "÷": switch divide(left: left, right: right) {
                case .success(let resultDivide) : do {
                        result = resultDivide
                    }
                case .failure(let error) : do {
                    return .failure(error)
                    }
                }
            default: return .failure(.whileComputing)
        }
        return .success(result)
    }
    
//    divide function, takes left and right params, check if != /0 and return result
    func divide(left: Double?, right: Double?) -> Result<Double, CustomError>  {
        guard let left = left, let right = right else {
            return .failure(.error)
        }
        if (right == 0.0) {
            return .failure(.divideByZero)
        } else {
            let result: Double = left / right
            return .success(result)
        }
    }
    
//    convert result to string
    func convertResult(result: Double) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 3
        guard let resultFormated = formatter.string(from: NSNumber(value: result)) else { return String() }
        return resultFormated
    }
}
