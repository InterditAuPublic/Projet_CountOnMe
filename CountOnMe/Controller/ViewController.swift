import UIKit
class ViewController: UIViewController {
    
    // MARK: Properties
    private let calculModel = CalculationModel()

    // MARK: Outlet
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!

    // MARK: View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        calculModel.removeAll()
        prepareView()
    }
    
    // MARK: IBActions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let number = sender.title(for: .normal) else {
            return
        }
        calculModel.addNumber(this: number)
    }
    
    @IBAction func tappedOperator(_ sender: UIButton) {
        guard let operatorSymbol = sender.titleLabel?.text else { return }
        calculModel.addOperator(with: operatorSymbol)
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculModel.calcul()
    }
    
    @IBAction func tappedDeleteButton(_ sender: UIButton) {
        calculModel.removeAll()
    }
    
    @IBAction func swipe(_ sender: UIGestureRecognizer) {
        calculModel.removeOne()
    }
    
    // MARK: Functions
    private func prepareView() {
        calculModel.calculToDisplay = { calculText in
            DispatchQueue.main.async {
                self.textView.text = calculText
            }
        }
    }
    
    // Create Alert for user
    private func alertUser(message : String) -> Void {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}

