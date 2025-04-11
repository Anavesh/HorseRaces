import Foundation

// MARK: - Race History Manager
/// Singleton-класс для управления историей заездов
final class RaceHistory {
    
    // MARK: - Singleton Instance
    /// Общий экземпляр для доступа к истории
    static let shared = RaceHistory()
    
    // MARK: - Initialization
    /// Приватный инициализатор для соблюдения паттерна Singleton
    private init() {}
    
    // MARK: - Data Storage
    /// Массив строк с результатами заездов (только для чтения)
    private(set) var races: [String] = []
    
    // MARK: - Public Methods
    
    /// Добавляет новый результат заезда в историю
    /// - Parameter result: Строка с результатом в формате "Horse X won at Y"
    func addRace(result: String) {
        races.insert(result, at: 0) // Новые результаты добавляются в начало
    }
    
    /// Полностью очищает историю заездов
    func clearHistory() {
        races.removeAll()
    }
}
