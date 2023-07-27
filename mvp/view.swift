import UIKit

protocol CalculatorView: AnyObject {
    func showDaysSinceCalculatorCreation(_ days: Int)
    func showNewCalculatorView()
}

class CalculatorViewController: UIViewController, CalculatorView {

    var presenter: CalculatorPresenter!
    var daysLabel: UILabel!
    var createButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let centerX = view.bounds.width / 2
        let centerY = view.bounds.height / 2

        daysLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        daysLabel.center = CGPoint(x: centerX, y: centerY)
        daysLabel.textAlignment = .center
        view.addSubview(daysLabel)

        let calculatorView = self
        let presenter = CalculatorPresenterImpl(calculatorView: calculatorView)
        calculatorView.presenter = presenter
        presenter.viewDidLoad()
    }

    func showDaysSinceCalculatorCreation(_ days: Int) {
        daysLabel.text = "Дней: \(days)"
    }

    func showNewCalculatorView() {
        let newCalculatorVC = NewCalculatorViewController()
        newCalculatorVC.presenter = CalculatorPresenterImpl(calculatorView: self)
        present(newCalculatorVC, animated: true, completion: nil)
    }
}

class NewCalculatorViewController: UIViewController {

    var presenter: CalculatorPresenter!
    var startDatePicker: UIDatePicker!
    var saveButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        let centerX = view.bounds.width / 2
        let centerY = view.bounds.height / 2

        startDatePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 200))
        startDatePicker.center = CGPoint(x: 75, y: centerY)
        startDatePicker.datePickerMode = .date
        view.addSubview(startDatePicker)

        saveButton = UIButton(type: .system)
        saveButton.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        saveButton.center = CGPoint(x: centerX, y: centerY + 100)
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        view.addSubview(saveButton)
    }

    @objc func saveButtonTapped() {
        presenter.createNewCalculator(startDate: startDatePicker.date)
        dismiss(animated: true, completion: nil)
    }
}
