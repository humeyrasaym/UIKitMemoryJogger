import UIKit

private enum LessonListLayout {
    static let horizontalPadding: CGFloat = 16
    static let topPadding: CGFloat = 12
    static let sectionSpacing: CGFloat = 20
    static let headerHeight: CGFloat = 142
}

final class LessonListViewController: UIViewController {
    private let viewModel: LessonListViewModel
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let headerView = ProgressHeaderView()
    private let headerContainerView = UIView()
    private let filterControl = UISegmentedControl(items: LessonListViewModel.Filter.allCases.map(\.title))

    init(viewModel: LessonListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Memory Jogger"
        view.backgroundColor = .systemGroupedBackground
        tableView.backgroundColor = .systemGroupedBackground
        setupFilterControl()
        setupTableView()
        bindViewModel()
        reloadContent()
    }

    private func setupFilterControl() {
        filterControl.selectedSegmentIndex = viewModel.selectedFilter.rawValue
        filterControl.addTarget(self, action: #selector(filterChanged), for: .valueChanged)
        filterControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterControl)

        NSLayoutConstraint.activate([
            filterControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LessonListLayout.topPadding),
            filterControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LessonListLayout.horizontalPadding),
            filterControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LessonListLayout.horizontalPadding)
        ])
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LessonCell.self, forCellReuseIdentifier: LessonCell.reuseIdentifier)
        setupHeaderContainer()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: filterControl.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupHeaderContainer() {
        headerContainerView.backgroundColor = .clear
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerContainerView.addSubview(headerView)

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: headerContainerView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: headerContainerView.bottomAnchor, constant: -LessonListLayout.sectionSpacing)
        ])
    }

    private func bindViewModel() {
        viewModel.onChange = { [weak self] in
            self?.reloadContent()
        }
    }

    private func reloadContent() {
        headerView.configure(progressText: viewModel.progressText, progress: viewModel.progress)
        tableView.reloadData()
    }

    @objc private func filterChanged() {
        viewModel.setFilter(index: filterControl.selectedSegmentIndex)
    }
}

extension LessonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.visibleLessons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: LessonCell.reuseIdentifier,
            for: indexPath
        ) as? LessonCell else {
            return UITableViewCell()
        }

        cell.configure(with: viewModel.lesson(at: indexPath.row))
        return cell
    }
}

extension LessonListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerContainerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        LessonListLayout.headerHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lesson = viewModel.lesson(at: indexPath.row)
        let detailViewController = LessonDetailViewController(lesson: lesson) { [weak self] lessonID in
            self?.viewModel.toggleRemembered(lessonID: lessonID)
        }
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
