import UIKit

// MARK: - Race Track View
/// Кастомная вью для отображения гоночной трассы и управления лошадьми
///
final class RaceTrackView: UIView {
    // MARK: - Properties
    /// Массив объектов лошадей на треке
    var horseViews: [HorseView] = []
    
    // MARK: - Public Methods
    
    /// Настройка и создание лошадей для гонки
    /// - Parameters:
    ///   - count: Количество лошадей
    ///   - colors: Массив цветов для каждой лошади
    func setupHorses(count: Int, colors: [UIColor]) {
        // Удаляем старых лошадей перед созданием новых
        horseViews.forEach { $0.removeFromSuperview() }
        
        // Создаем новых лошадей с заданными цветами
        horseViews = (0..<count).map { index in
            let horse = HorseView()
            horse.backgroundColor = colors[index]
            addSubview(horse)
            return horse
        }
        layoutHorses()
    }
    
    /// Запуск гонки со случайной длительностью для каждой лошади
    /// - Parameters:
    ///   - durationRange: Диапазон возможных длительностей гонки
    ///   - delegate: Делегат для обработки завершения гонки
    func startRace(durationRange: ClosedRange<Double>, delegate: HorseViewDelegate) {
        let finishLineX = bounds.width - 66 // Финишная линия (66pt от правого края)
        
        // Запускаем всех лошадей с разной скоростью
        horseViews.forEach { horse in
            horse.delegate = delegate
            let duration = Double.random(in: durationRange)
            horse.startRace(duration: duration, finishLineX: finishLineX)
        }
    }
    
    /// Сброс лошадей в начальную позицию
    func resetHorses() {
        horseViews.forEach { $0.resetPosition(initialX: 16) }
    }
    
    // MARK: - Layout
    
    /// Расстановка лошадей на стартовой позиции
    private func layoutHorses() {
        let horseHeight: CGFloat = 30
        let spacing: CGFloat = 10
        
        // Вертикальное расположение с равными отступами
        for (index, horse) in horseViews.enumerated() {
            let yPosition = CGFloat(index) * (horseHeight + spacing) + spacing
            horse.frame = CGRect(
                x: 16, // Стартовая позиция по X
                y: yPosition,
                width: 50,
                height: horseHeight
            )
        }
    }
    
    // MARK: - View Updates
    /// Автоматический вызов при изменении размера вью
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutHorses() // Обновляем позиции при изменении layout
    }
}
