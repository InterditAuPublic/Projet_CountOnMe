import UIKit

// Preparer les messages d'erreurs
enum ErrorMessage: String {
    case error = "Erreur"
    case whileComputing = "Erreur lors du calcul"
    case numberIsRequired = "Vous devez saisir des nombres !"
    case expressionIsIncorrect = "Impossible d'ajouter un operateur"
    case divisionByZero = "Division par 0 !"
    case newCalcul = "Demarrer un nouveau calcul !"
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
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let number = sender.title(for: .normal) else { return }
        
        guard !calculModel.expressionHaveResult(elements: elements) else {
            return alertUser(message: ErrorMessage.newCalcul.rawValue)
        }
        textView.text.append(number)
    }
    
    @IBAction func tappedOperator(_ sender: UIButton) {
        guard let operatorSymbol = sender.titleLabel?.text else { return }
        switch calculModel.canAddOperator(elements: elements) {
           case .success():
               self.textView.text.append(operatorSymbol)
           case .failure(let errorType) :
               return alertUser(message: errorType.errorDescription)
        }
    }
        
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        switch calculModel.result(elements: elements) {
        case .success(let result):
            self.textView.text.append(" = \(result)")
        case .failure(let errorType) :
            return alertUser(message: errorType.errorDescription)
        }
    }
    
    @IBAction func tappedDeleteButton(_ sender: UIButton) {
        removeAll()
    }
    
    @IBAction func swipe(_ sender: UIGestureRecognizer) {
        removeOne()
    }
    
    // MARK: Functions
    private func prepareView() {
        textView.text.removeAll()
    }
    
    @IBAction func tappedDots(_ sender: UIButton) {
        guard (sender.titleLabel?.text) != nil else {
            return
        }
        textView.text.append(".")
    }
    
    func removeOne() {
        guard textView.text.first != nil else {
            alertUser(message: "Il n'y a pas d'élement à effacer")
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

