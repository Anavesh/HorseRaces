import UIKit

// MARK: - Alert Manager
/// Утилитарный класс для управления системными уведомлениями
struct AlertManager {
    
    // MARK: - Race Results
    
    /// Показывает алерт с результатами гонки
    /// - Parameters:
    ///   - viewController: Контроллер, на котором будет показан алерт
    ///   - horseNumber: Номер победившей лошади
    ///   - completion: Замыкание, выполняемое после нажатия кнопки OK
    static func showRaceWinner(
        on viewController: UIViewController,
        horseNumber: Int,
        completion: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(
            title: "🏁 Race Finished!",
            message: "Horse \(horseNumber) won the race!",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(
            title: "OK",
            style: .default) { _ in
                completion?()
            }
        
        alert.addAction(okAction)
        viewController.present(alert, animated: true)
    }
    
    // MARK: - Generic Alerts
    
    /// Показывает стандартный информационный алерт
    /// - Parameters:
    ///   - viewController: Контроллер для отображения
    ///   - title: Заголовок уведомления
    ///   - message: Основной текст сообщения
    static func showGenericAlert(
        on viewController: UIViewController,
        title: String,
        message: String
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(
            title: "OK",
            style: .default)
        )
        
        viewController.present(alert, animated: true)
    }
}
