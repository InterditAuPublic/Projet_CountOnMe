import UIKit

// Preparer les messages d'erreurs
enum ErrorMessage: String {
    case newCalcul = "Demarrer un nouveau calcul !"
    case noNumber = "Il n'y a pas d'élement à effacer"
}

class ViewController: UIViewController {
    
    // MARK: Properties
    private let calculModel = CalculationModel()
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }

    // MARK: Outlet
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!

    // MARK: View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    // MARK: IBActions
    // When the user tap on a number
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let number = sender.title(for: .normal) else { return }
        
        guard !calculModel.expressionHaveResult(elements: elements) else {
            return alertUser(message: ErrorMessage.newCalcul.rawValue)
        }
        textView.text.append(number)
    }
    
    // When the user tap on an operator
    @IBAction func tappedOperator(_ sender: UIButton) {
        guard let operatorSymbol = sender.titleLabel?.text else { return }
        switch calculModel.canAddOperator(elements: elements) {
           case .success():
               self.textView.text.append(operatorSymbol)
           case .failure(let errorType) :
               return alertUser(message: errorType.errorDescription)
        }
    }
        
    // When the user tap on equal
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        switch calculModel.result(elements: elements) {
        case .success(let result):
            self.textView.text.append(" = \(result)")
        case .failure(let errorType) :
            return alertUser(message: errorType.errorDescription)
        }
    }
    
    // When the user tap on delete
    @IBAction func tappedDeleteButton(_ sender: UIButton) {
        removeAll()
    }
    
    // When the user swipe into the resultView
    @IBAction func swipe(_ sender: UIGestureRecognizer) {
        removeOne()
    }
    
    // When the user tap on dots
    @IBAction func tappedDots(_ sender: UIButton) {
        switch calculModel.canAddDots(elements: elements) {
           case .success():
               self.textView.text.append(".")
           case .failure(let errorType) :
               return alertUser(message: errorType.errorDescription)
        }
    }
    
    // MARK: Functions
    private func prepareView() {
        textView.text.removeAll()
    }
    
    // Remove last element of the textView || If TextView contain a result, remove all elements
    func removeOne() {
        guard textView.text.first != nil else {
            alertUser(message: ErrorMessage.noNumber.rawValue)
            return
        }
        guard !calculModel.expressionHaveResult(elements: elements) else {
            textView.text.removeAll()
            return
        }
        var text = Array(textView.text)
        text.remove(at: textView.text.count - 1)
        textView.text = String(text)
    }
    
    // Remove all elements of the textView
    func removeAll() {
        textView.text.removeAll()
    }
    
    // Create Alert for user
    private func alertUser(message : String) -> Void {
        let alertVC = UIAlertController(title: "Oups !", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}

