import UIKit

// MARK: - Race History Controller
/// Контроллер для отображения истории заездов
final class RaceHistoryViewController: UIViewController {
    
    // MARK: - UI Components
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
    }
    
    // MARK: - Configuration
    private func configureViewController() {
        setupAppearance()
        setupTableView()
        setupConstraints()
    }
    
    /// Настройка базовых параметров внешнего вида
    private func setupAppearance() {
        view.backgroundColor = .systemBackground
        title = "Race History"
    }
    
    // MARK: - Table View Setup
    private func setupTableView() {
        view.addSubview(tableView)
        
        // Базовые настройки таблицы
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "HistoryCell"
        )
        tableView.dataSource = self
    }
    
    /// Обновление данных таблицы
    private func refreshData() {
        tableView.reloadData()
    }
    
    // MARK: - Layout
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

// MARK: - Table View Data Source
extension RaceHistoryViewController: UITableViewDataSource {
    /// Количество ячеек соответствует количеству записей в истории
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RaceHistory.shared.races.count
    }
    
    /// Конфигурация ячейки с историей заездов
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "HistoryCell",
            for: indexPath
        )
        
        // Форматирование содержимого ячейки
        let raceRecord = RaceHistory.shared.races[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = raceRecord
        
        return cell
    }
}
