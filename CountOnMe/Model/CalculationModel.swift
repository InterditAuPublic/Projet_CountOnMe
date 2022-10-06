import Foundation

class CalculationModel {

    var elements: [String] = [] //private ?

    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷" && !elements.isEmpty
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionHaveResult: Bool {
        return elements.firstIndex(of: "=") != nil
    }
    
    func setExpression(elements : String) {
        if !elements.isEmpty {
            self.elements = elements.split(separator: " ").map { "\($0)" }
        }
    }

    private func calculationPriority() {
        var index = 0
        while index < elements.count {
            if elements[index] == "x" || elements[index] == "÷" {
//                let newNumber = calculate(left: Double(elements[index - 1])!, operand: elements[index], right: Double(elements[index + 1])!)
//                elements[index - 1] = ("\(clearResult())")
                elements.remove(at: index)
                elements.remove(at: index)
                index = 0
            }
            index += 1
        }
    }
    
//    private func calculate(left : Double, operand : String, right : Double) -> Double{
//
//    }
//
    func addition(a: Int, b: Int) -> Int {
        return a + b
    }
}
