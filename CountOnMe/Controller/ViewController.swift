import UIKit
class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    private let calculate = CalculationModel()
    
    private var elements: String {
        return textView.text
    }
//    var elements: [String] {
//        return textView.text.split(separator: " ").map { "\($0)" }
//    }
//
//    // Error check computed variables
//    var expressionIsCorrect: Bool {
//        return elements.last != "+" && elements.last != "-"
//    }
    
//    var expressionHaveEnoughElement: Bool {
//        return elements.count >= 3
//    }
    
//    var canAddOperator: Bool {
//        return elements.last != "+" && elements.last != "-"
//    }
    
//    var expressionHaveResult: Bool {
//        return textView.text.firstIndex(of: "=") != nil
//    }
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        if expressionHaveResult {
            textView.text = ""
        }
        
        textView.text.append(numberText)
    }
    
    //MARK: CREATE tappedCalculatorButton() func that contains all tapped***() ?
    
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if calculate.canAddOperator {
            textView.text.append(" + ")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if calculate.canAddOperator {
            textView.text.append(" - ")
        } else {
            present(alertUser(message: "Un operateur est déja mis !"), animated: true, completion: nil)
            return
        }
    }

    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        if calculate.canAddOperator {
            textView.text.append(" x ")
        } else {
            present(alertUser(message: "Un operateur est déja mis !"), animated: true, completion: nil)
            return
        }
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        if calculate.canAddOperator {
            textView.text.append(" ÷ ")
        } else {
            present(alertUser(message: "Un operateur est déja mis !"), animated: true, completion: nil)
            return
        }
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard calculate.expressionIsCorrect else {
            present(alertUser(message: "Entrez une expression correcte !"), animated: true, completion: nil)
            return
        }
        
        guard calculate.expressionHaveEnoughElement else {
            present(alertUser(message: "Démarrez un nouveau calcul !"), animated: true, completion: nil)
            return
        }
        
        // Create local copy of operations
        var operationsToReduce = calculate.elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            
            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "÷": result = left / right
            case "x": result = left * right
            default: fatalError("Unknown operator !")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        
        textView.text.append(" = \(operationsToReduce.first!)")
    }

    @IBAction func tappedDeleteButton(_ sender: UIButton) {
        textView.text.removeAll()
    }
    
    @IBAction func swipe(_ sender: UIGestureRecognizer) {
        calculate.setExpression(elements: elements)
        guard textView.text.first != nil else {
            present(alertUser(message: "Il n'y a pas d'élement à effacer"), animated: true, completion: nil)
            return
        }
        guard !calculate.expressionHaveResult else {
            textView.text.removeAll()
            return
        }
        var text = Array(textView.text)
        text.remove(at: textView.text.count - 1)
        textView.text = String(text)
    }
    
    private func alertUser(message : String) -> UIAlertController{
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alertVC
    }
}

