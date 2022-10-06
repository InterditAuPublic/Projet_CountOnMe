import Foundation

// Preparer les messages d'erreurs
enum errorMessage: String {
    case error
}

class CalculationModel {

    // MARK: Properties
    var calculToDisplay: ((String) -> Void)?
    
    private var elements: [String] {
        return calculString.split(separator: " ").map { "\($0)" }
    }
    
    var calculString: String = "" {
        didSet {
            calculToDisplay?(calculString)
        }
    }

    //Check if Expression is valid
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷" && !elements.isEmpty
    }

    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    var expressionHaveResult: Bool {
        return elements.firstIndex(of: "=") != nil
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷"
    }
    
    var divideByZero: Bool {
        return elements.contains("÷ 0")
    }
    
    // MARK: Functions
    
    func addOperator(with operatorSymbol: String) {
        if expressionIsCorrect {
            calculString.append(operatorSymbol)
        } else {
//            alertUser("Un operateur est déja mis !")
        }
    }
    
    func addNumber(this number: String) {
        if expressionHaveResult {
            removeAll()
            calculString.append(number)
        } else {
            calculString.append(number)
        }
        print(calculString)
    }
    
    func removeOne() {
//        guard textView.text.first != nil else {
//            alertUser(message: "Il n'y a pas d'élement à effacer")
//            return
//        }
//        guard !calculModel.expressionHaveResult else {
//            textView.text.removeAll()
//            return
//        }
//        var text = Array(textView.text)
//        text.remove(at: textView.text.count - 1)
//        textView.text = String(text)
    }
    
    func removeAll() {
        calculString.removeAll()
        calculToDisplay?("0")
    }
    
    func calcul(){
        guard canBeComputed() else {
            return
        }
    }
    
    private func canBeComputed() -> Bool {
        guard expressionIsCorrect else {
//            alertUser("Un operateur est déja mis !")
            return false
        }

        guard expressionHaveEnoughElement else {
//            alertUser("Démarrez un nouveau calcul !")
            return false
        }

        guard !divideByZero else {
//           alertUser("division par 0")
            return false
        }
        return true
    }
    
    private func calculationPriority() {
        
    }
    
    private func calculate(left: Double, right: Double, operand: String) -> Double {
        let result: Double

        switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "÷": result = left / right
            case "x": result = left * right
            default: return 0.0
        }
        return result
    }
}
