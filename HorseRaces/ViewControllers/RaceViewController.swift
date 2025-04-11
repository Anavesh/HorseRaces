import UIKit

// MARK: - Race State
/// Состояния гоночного процесса
enum RaceState {
    case readyToStart    // Готов к старту, лошади на позициях
    case inProgress      // Гонка начата, лошади в движении
    case finished        // Гонка завершена, есть победитель
}

// MARK: - Race View Controller
/// Основной контроллер управления гонкой
final class RaceViewController: UIViewController {
    
    // MARK: - UI Components
    private let raceTrack = RaceTrackView()       // Вью трека с лошадьми
    private let controlPanel = ControlPanelView() // Панель управления гонкой
    
    // MARK: - Race State Management
    /// Текущее состояние гонки с автоматическим обновлением UI
    private var currentState: RaceState = .readyToStart {
        didSet {
            controlPanel.updateState(currentState)
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    // MARK: - Configuration
    /// Основная настройка контроллера
    private func configureViewController() {
        setupAppearance()
        setupLayout()
        setupEventHandlers()
        prepareRaceTrack()
    }
    
    /// Настройка визуальных параметров
    private func setupAppearance() {
        view.backgroundColor = .white
        raceTrack.backgroundColor = .systemGray6
    }
    
    /// Настройка расположения элементов
    private func setupLayout() {
        [raceTrack, controlPanel].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            // Констрейнты для трека
            raceTrack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            raceTrack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            raceTrack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            raceTrack.heightAnchor.constraint(equalToConstant: 300),
            
            // Констрейнты для панели управления
            controlPanel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            controlPanel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            controlPanel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            controlPanel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    /// Подготовка трека к гонке
    private func prepareRaceTrack() {
        raceTrack.setupHorses(
            count: 5,
            colors: UIColor.horseColors
        )
    }
    
    // MARK: - Event Handling
    /// Настройка обработчиков событий
    private func setupEventHandlers() {
        controlPanel.startAction = { [weak self] in
            self?.handleRaceStart()
        }
        
        controlPanel.restartAction = { [weak self] in
            self?.handleRaceReset()
        }
    }
    
    /// Запуск новой гонки
    private func handleRaceStart() {
        currentState = .inProgress
        raceTrack.startRace(
            durationRange: 3...6,
            delegate: self
        )
    }
    
    /// Сброс гонки в начальное состояние
    private func handleRaceReset() {
        raceTrack.resetHorses()
        currentState = .readyToStart
    }
}

// MARK: - Horse Race Delegate
extension RaceViewController: HorseViewDelegate {
    
    /// Обработчик завершения гонки лошадью
    func horseDidFinishRace(_ horse: HorseView) {
        guard currentState == .inProgress else { return }
        
        // Экстренная остановка всех участников
        raceTrack.stopAllHorses()
        
        // Обновление состояния системы
        currentState = .finished
        
        // Запись результата
        recordRaceResult(for: horse)
        
        // Показ уведомления
        showRaceResultAlert(for: horse)
    }
    
    // MARK: - Result Processing
    /// Сохранение результатов гонки
    private func recordRaceResult(for horse: HorseView) {
        guard let index = raceTrack.horseViews.firstIndex(of: horse) else { return }
        
        let result = "Horse \(index + 1) won at \(Date().formatted())"
        RaceHistory.shared.addRace(result: result)
    }
    
    /// Отображение результатов
    private func showRaceResultAlert(for horse: HorseView) {
        guard let index = raceTrack.horseViews.firstIndex(of: horse) else { return }
        AlertManager.showRaceWinner(on: self, horseNumber: index + 1)
    }
}
