import UIKit

// MARK: - Application Color Palette
/// Кастомные цвета приложения, централизованные для единообразия
extension UIColor {
    
    // MARK: Main Theme
    /// Основной акцентный цвет приложения
    /// Используется для: активных элементов, кнопок, выделений
    static let appAccent = #colorLiteral(red: 0.239, green: 0.231, blue: 0.953, alpha: 1)
    
    /// Фоновый цвет таб-бара
    /// Используется для: подложки нижней панели навигации
    static let tabBarBackground = #colorLiteral(red: 0.922, green: 0.918, blue: 1.0, alpha: 1)
    
    // MARK: Text & UI Elements
    /// Цвет текста для неактивных элементов
    /// Используется для: иконок/текста неактивных вкладок
    static let inactiveText = #colorLiteral(red: 1.0, green: 0.161, blue: 0.161, alpha: 1)
    
    // MARK: Race Track Colors
    /// Цвета для лошадей на треке
    /// Используется для: визуального различия участников заезда
    static let horseColors: [UIColor] = [
        .systemRed,
        .systemBlue,
        .systemGreen,
        .systemOrange,
        .systemPurple
    ]
    
    // MARK: Backgrounds
    /// Основной фоновый цвет экранов
    /// Используется для: фона всех экранов приложения
    static let appBackground = UIColor.systemBackground
    
    /// Вторичный фоновый цвет
    /// Используется для: контейнеров, разделителей
    static let secondaryBackground = UIColor.secondarySystemBackground
}
