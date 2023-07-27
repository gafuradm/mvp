import Foundation

protocol CalculatorPresenter {
    func viewDidLoad()
    func createNewCalculator(startDate: Date)
}

class CalculatorPresenterImpl: CalculatorPresenter {

    weak var calculatorView: CalculatorView?
    let userDefaults = UserDefaults.standard
    let startDateKey = "startDate"

    init(calculatorView: CalculatorView) {
        self.calculatorView = calculatorView
    }

    func viewDidLoad() {
        if let startDate = userDefaults.object(forKey: startDateKey) as? Date {
            let currentDate = Date()
            let days = Calendar.current.dateComponents([.day], from: startDate, to: currentDate).day ?? 0
            calculatorView?.showDaysSinceCalculatorCreation(days)
        } else {
            calculatorView?.showNewCalculatorView()
        }
    }

    func createNewCalculator(startDate: Date) {
        userDefaults.set(startDate, forKey: startDateKey)
        let currentDate = Date()
        let days = Calendar.current.dateComponents([.day], from: startDate, to: currentDate).day ?? 0
        calculatorView?.showDaysSinceCalculatorCreation(days)
    }
}
