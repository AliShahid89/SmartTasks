//
//  TasksViewController.swift
//  SmartTasks
//
//  Created by Ali Shahid on 08/06/2024.
//

import UIKit

final class TasksViewController: UIViewController {
  
  // Interactor to handle business logic
  var interactor: TasksInteractorProtocol?
  // Router to handle navigation
  var router: TasksRouterProtocol?
  
  // Array of view models to populate the table view
  private var viewModels = [TaskViewModel]()
  
  // Table view to display the tasks
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.dataSource = self
    tableView.delegate = self
    tableView.backgroundColor = .clear
    tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    tableView.separatorStyle = .none
    return tableView
  }()
  
  // View to display when there are no tasks
  private lazy var noTasksView: NoTasksView = {
    let view = NoTasksView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  // Activity indicator to show progress
  private let activityIndicator = UIActivityIndicatorView(style: .large)
  
  // Load view programmatically
  override func loadView() {
    view = UIView(frame: UIScreen.main.bounds)
    view.backgroundColor = .white
  }
  
  // Called after the view has been loaded
  public override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    setupMainView()
    setupActivityIndicator()
    fetchData()
    setupNavigationBar()
  }
  
  // Setup the navigation bar appearance and buttons
  // Wanted to make a separate component for Navigation bar as well. Couldn't do as per time constraint.
  private func setupNavigationBar() {
    let titleFont = SmartTasksUI.font(type: .bold, size: .large)
    
    navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: titleFont]
    
    let backButton = UIBarButtonItem(image: UIImage(named: "back-arrow"), style: .plain, target: self, action: #selector(backButtonTapped))
    let forwardButton = UIBarButtonItem(image: UIImage(named: "forward-arrow"), style: .plain, target: self, action: #selector(forwardButtonTapped))
    navigationItem.leftBarButtonItem = backButton
    navigationItem.rightBarButtonItem = forwardButton
    
    // Background Color
    navigationController?.navigationBar.backgroundColor = SmartTasksUI.Colors.yellowBackgroundColor
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.barTintColor = SmartTasksUI.Colors.yellowBackgroundColor
    
    // Remove Separator
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
  }
  
  // Action for back button tap
  @objc private func backButtonTapped() {
    showActivityIndicator()
    interactor?.fetchTasksForDate(.previous)
  }
  
  // Action for forward button tap
  @objc private func forwardButtonTapped() {
    showActivityIndicator()
    interactor?.fetchTasksForDate(.next)
  }
  
  // Setup the table view layout and constraints
  private func setupTableView() {
    view.backgroundColor = .white
    view.addSubview(tableView)
    tableView.backgroundColor = SmartTasksUI.Colors.yellowBackgroundColor
    
    NSLayoutConstraint.activate([
      tableView.safeTop.constraint(equalTo: view.safeTop),
      tableView.safeLeading.constraint(equalTo: view.safeLeading),
      tableView.safeTrailing.constraint(equalTo: view.safeTrailing),
      tableView.safeBottom.constraint(equalTo: view.safeBottom)
    ])
  }
  
  // Setup the main view's appearance
  private func setupMainView() {
    self.title = "Today"
    view.backgroundColor = SmartTasksUI.Colors.yellowBackgroundColor
  }
  
  // Setup the activity indicator layout and constraints
  private func setupActivityIndicator() {
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(activityIndicator)
    
    NSLayoutConstraint.activate([
      activityIndicator.centerX.constraint(equalTo: view.centerX),
      activityIndicator.centerY.constraint(equalTo: view.centerY)
    ])
  }
  
  // Show activity indicator and disable user interaction
  private func showActivityIndicator() {
    activityIndicator.startAnimating()
    view.isUserInteractionEnabled = false
  }
  
  // Hide activity indicator and enable user interaction
  private func hideActivityIndicator() {
    activityIndicator.stopAnimating()
    view.isUserInteractionEnabled = true
  }
  
  // Fetch tasks from the interactor
  private func fetchData() {
    showActivityIndicator()
    interactor?.fetchAllTasks()
  }
}

// Extension to conform to TasksViewProtocol
extension TasksViewController: TasksViewProtocol {
  
  // Populate table view with tasks
  func populateTasks(targetDate: String, viewModels: [TaskViewModel]) {
    hideActivityIndicator()
    
    self.title = targetDate
    self.viewModels = viewModels
    
    noTasksView.isHidden = true
    
    tableView.isHidden = false
    tableView.reloadData()
  }
  
  // Show no tasks for today view
  func noTasksForToday(targetDate: String) {
    hideActivityIndicator()
    
    self.title = targetDate
    
    tableView.isHidden = true
    noTasksView.isHidden = false
    
    view.addSubview(noTasksView)
    
    // Set up constraints for noTasksView to center it in the view
    NSLayoutConstraint.activate([
      noTasksView.centerX.constraint(equalTo: view.centerX),
      noTasksView.centerY.constraint(equalTo: view.centerY),
      noTasksView.safeLeading.constraint(equalTo: view.safeLeading, constant: 20),
      noTasksView.safeTrailing.constraint(equalTo: view.safeTrailing, constant: -20)
    ])
  }
}

// Extension to conform to UITableViewDelegate and UITableViewDataSource
extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
  
  // Return the number of rows in the section
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModels.count
  }
  
  // Configure the cell for the row at indexPath
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier, for: indexPath) as? TaskTableViewCell else {
      return UITableViewCell()
    }
    
    let viewModel = viewModels[indexPath.row]
    cell.setup(viewModel)
    
    return cell
  }
  
  // Handle row selection
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    router?.routeToTaskDetails(viewModels[indexPath.row].taskEntity)
  }
}
