import UIKit

// MARK: - Horse View Delegate
/// Протокол для отслеживания завершения гонки лошадью
protocol HorseViewDelegate: AnyObject {
    func horseDidFinishRace(_ horse: HorseView)
}

// MARK: - Horse View
/// Кастомное представление лошади с анимацией движения
final class HorseView: UIView {
    
    // MARK: - Properties
    weak var delegate: HorseViewDelegate?
    private var animator: UIViewPropertyAnimator?
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    private func configureAppearance() {
        backgroundColor = .systemRed
        layer.cornerRadius = 4
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Race Control
    
    /// Немедленно останавливает гонку и фиксирует текущую позицию
    func stopRace() {
        animator?.stopAnimation(true)
        // Сохраняем текущую позицию из presentation layer
        if let presentationFrame = layer.presentation()?.frame {
            frame = presentationFrame
        }
    }
    
    /// Начинает гонку с указанной длительностью
    /// - Parameters:
    ///   - duration: Время гонки в секундах
    ///   - finishLineX: X-координата финишной линии
    func startRace(duration: TimeInterval, finishLineX: CGFloat) {
        animator?.stopAnimation(true)
        
        animator = UIViewPropertyAnimator(
            duration: duration,
            timingParameters: UICubicTimingParameters(animationCurve: .linear)
        )
        
        animator?.addAnimations { [weak self] in
            self?.frame.origin.x = finishLineX
        }
        
        animator?.addCompletion { [weak self] _ in
            guard let self = self else { return }
            self.delegate?.horseDidFinishRace(self)
        }
        
        animator?.startAnimation()
    }
    
    /// Сбрасывает позицию лошади на стартовую
    /// - Parameter initialX: Начальная X-координата
    func resetPosition(initialX: CGFloat) {
        animator?.stopAnimation(true)
        frame.origin.x = initialX
    }
}
