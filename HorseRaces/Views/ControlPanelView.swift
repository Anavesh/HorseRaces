import UIKit

// MARK: - Control Panel View
/// Кастомная панель управления с кнопками старта и перезапуска гонки
final class ControlPanelView: UIView {
    
    // MARK: - UI Elements
    private let stackView = UIStackView()
    private let startButton = UIButton()
    private let restartButton = UIButton()
    
    // MARK: - Action Handlers
    /// Замыкание для обработки нажатия на кнопку старта
    var startAction: (() -> Void)?
    /// Замыкание для обработки нажатия на кнопку перезапуска
    var restartAction: (() -> Void)?
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Setup Methods
    private func setupView() {
        setupButtons()
        setupStackView()
        setupConstraints()
        updateState(.readyToStart)
    }
    
    // MARK: - State Management
    /// Обновляет внешний вид кнопок в зависимости от состояния гонки
    /// - Parameter state: Текущее состояние гонки из перечисления RaceState
    func updateState(_ state: RaceState) {
        switch state {
        case .readyToStart:
            // Только кнопка старта видима и активна
            startButton.isHidden = false
            restartButton.isHidden = true
            startButton.isEnabled = true
            
        case .inProgress:
            // Все кнопки скрыты во время гонки
            startButton.isHidden = true
            restartButton.isHidden = true
            
        case .finished:
            // Только кнопка перезапуска видима и активна
            startButton.isHidden = true
            restartButton.isHidden = false
            restartButton.isEnabled = true
        }
        
        // Плавное обновление layout
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
    }
    
    // MARK: - Button Configuration
    private func setupButtons() {
        // Настройка кнопки "Start Race"
        startButton.setTitle("Start Race", for: .normal)
        startButton.backgroundColor = .systemBlue
        startButton.layer.cornerRadius = 8
        startButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
        
        // Настройка кнопки "Restart"
        restartButton.setTitle("Restart", for: .normal)
        restartButton.backgroundColor = .systemGreen
        restartButton.layer.cornerRadius = 8
        restartButton.addTarget(self, action: #selector(restartTapped), for: .touchUpInside)
    }
    
    // MARK: - Stack View Setup
    private func setupStackView() {
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(startButton)
        stackView.addArrangedSubview(restartButton)
        addSubview(stackView)
    }
    
    // MARK: - Layout Constraints
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    // MARK: - Button Actions
    @objc private func startTapped() {
        startAction?()
    }
    
    @objc private func restartTapped() {
        restartAction?()
    }
}
