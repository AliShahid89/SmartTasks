//
//  TaskDetailsViewController.swift
//  SmartTasks
//
//  Created by Ali Shahid on 09/06/2024.
//

import UIKit

final class TaskDetailsViewController: UIViewController {
  
  // Interactor to handle business logic
  var interactor: TaskDetailsInteractorProtocol?
  
  // Router to handle navigation
  var router: TaskDetailsRouterProtocol?
  
  // Main container view with rounded corners and a clear background
  private lazy var mainContainerView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 5.0
    view.clipsToBounds = true
    view.backgroundColor = .clear
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  // Background imageView
  private lazy var backgroundImage: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "task_details_background")
    imageView.clipsToBounds = true
    imageView.backgroundColor = .clear
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  // Main vertical stack view for arranging subviews vertically
  private lazy var mainVerticalStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.spacing = 10.0
    return stackView
  }()
  
  // Stack view for title and date
  private lazy var titleDateStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.spacing = 5.0
    return stackView
  }()
  
  // Stack view for due date and days left
  private lazy var dueDateDaysLeftStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.spacing = 10.0
    return stackView
  }()
  
  // Stack view for due date labels
  private lazy var dueDateStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.spacing = 7.0
    return stackView
  }()
  
  // Stack view for days left labels
  private lazy var daysLeftStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .trailing
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.spacing = 7.0
    return stackView
  }()
  
  // Custom labels for task details
  
  private lazy var taskTitleLabel: CustomLabel = {
    let label = CustomLabel(text: "Task Title", font: SmartTasksUI.font(type: .bold, size: .Extralarge), textColor: SmartTasksUI.Colors.redColor)
    label.setContentHuggingPriority(.defaultHigh, for: .vertical)
    return label
  }()
  
  private lazy var daysLeftValueLabel: CustomLabel = {
    let label = CustomLabel(font: SmartTasksUI.font(type: .bold, size: .medium), textColor: SmartTasksUI.Colors.redColor)
    return label
  }()
  
  private lazy var dueDateLabel: CustomLabel = {
    let label = CustomLabel(text: "Due date", font: SmartTasksUI.font(type: .regular, size: .small), textColor: SmartTasksUI.Colors.grayColor)
    return label
  }()
  
  private lazy var dueDateValueLabel: CustomLabel = {
    let label = CustomLabel(font: SmartTasksUI.font(type: .bold, size: .medium), textColor: SmartTasksUI.Colors.redColor)
    return label
  }()
  
  private lazy var daysLeftLabel: CustomLabel = {
    let label = CustomLabel(text: "Days left", font: SmartTasksUI.font(type: .regular, size: .small), textColor: SmartTasksUI.Colors.grayColor)
    return label
  }()
  
  private lazy var taskDescriptionLabel: CustomLabel = {
    let label = CustomLabel(font: SmartTasksUI.font(type: .regular, size: .medium), textColor: SmartTasksUI.Colors.grayColor)
    label.setContentHuggingPriority(.defaultHigh, for: .vertical)
    return label
  }()
  
  private lazy var taskStatusLabel: CustomLabel = {
    let label = CustomLabel(font: SmartTasksUI.font(type: .bold, size: .medium))
    return label
  }()
  
  // Resolve and Can't resolve buttons
  private lazy var resolveButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Resolve", for: .normal)
    button.titleLabel?.font = SmartTasksUI.font(type: .bold, size: .large)
    button.backgroundColor = SmartTasksUI.Colors.grayColor
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = 5.0
    button.translatesAutoresizingMaskIntoConstraints = false
    
    button.addTarget(self, action: #selector(resolveButtonTapped), for: .touchUpInside)
    
    return button
  }()
  
  private lazy var cantResolveButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Can't resolve", for: .normal)
    button.titleLabel?.font = SmartTasksUI.font(type: .bold, size: .large)
    button.backgroundColor = SmartTasksUI.Colors.redColor
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = 5.0
    button.translatesAutoresizingMaskIntoConstraints = false
    
    button.addTarget(self, action: #selector(cantResolveButtonTapped), for: .touchUpInside)
    
    return button
  }()
  
  private lazy var buttonStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.spacing = 10.0
    stackView.addArrangedSubview(resolveButton)
    stackView.addArrangedSubview(cantResolveButton)
    return stackView
  }()
  
  private lazy var taskStatusImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  // Load view programmatically
  override func loadView() {
    view = UIView(frame: UIScreen.main.bounds)
  }
  
  // Called after the view has been loaded
  public override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    fetchData()
    setupNavigationBar()
  }
  
  // #ALI Refactor this.
  private func setupNavigationBar() {
    navigationItem.title = "Task Detail"
    
    let titleFont = SmartTasksUI.font(type: .bold, size: .large)
    
    navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: titleFont]
    
    let backButton = UIBarButtonItem(image: UIImage(named: "back-arrow"), style: .plain, target: self, action: #selector(backButtonTapped))
    
    navigationItem.leftBarButtonItem = backButton
    
    // Background Color
    navigationController?.navigationBar.backgroundColor = SmartTasksUI.Colors.yellowBackgroundColor
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.barTintColor = SmartTasksUI.Colors.yellowBackgroundColor
    
    // Remove Separator
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
  }
}

private extension TaskDetailsViewController {
  
  func setupViews() {
    view.backgroundColor = SmartTasksUI.Colors.yellowBackgroundColor
    
    view.addSubview(mainContainerView)
    view.addSubview(buttonStackView)
    
    mainContainerView.addSubview(backgroundImage)
    
    mainContainerView.addSubview(mainVerticalStackView)
    
    titleDateStackView.addArrangedSubview(taskTitleLabel)
    
    dueDateStackView.addArrangedSubview(dueDateLabel)
    dueDateStackView.addArrangedSubview(dueDateValueLabel)
    
    dueDateDaysLeftStackView.addArrangedSubview(dueDateStackView)
    dueDateDaysLeftStackView.addArrangedSubview(UIView.spacer)
    
    daysLeftStackView.addArrangedSubview(daysLeftLabel)
    daysLeftStackView.addArrangedSubview(daysLeftValueLabel)
    dueDateDaysLeftStackView.addArrangedSubview(daysLeftStackView)
    
    mainVerticalStackView.addArrangedSubview(titleDateStackView)
    mainVerticalStackView.addArrangedSubview(UIView.customSeparatorView)
    mainVerticalStackView.addArrangedSubview(dueDateDaysLeftStackView)
    mainVerticalStackView.addArrangedSubview(UIView.customSeparatorView)
    mainVerticalStackView.addArrangedSubview(taskDescriptionLabel)
    mainVerticalStackView.addArrangedSubview(UIView.customSeparatorView)
    mainVerticalStackView.addArrangedSubview(taskStatusLabel)
    
    NSLayoutConstraint.activate([
      mainContainerView.safeTop.constraint(equalTo: view.safeTop, constant: 20.0),
      mainContainerView.safeLeading.constraint(equalTo: view.safeLeading, constant: 15.0),
      mainContainerView.safeTrailing.constraint(equalTo: view.safeTrailing, constant: -15.0)
    ])
    
    NSLayoutConstraint.activate([
      mainVerticalStackView.safeTop.constraint(equalTo: mainContainerView.safeTop, constant: 50.0),
      mainVerticalStackView.safeLeading.constraint(equalTo: mainContainerView.safeLeading, constant: 10.0),
      mainVerticalStackView.safeTrailing.constraint(equalTo: mainContainerView.safeTrailing, constant: -10.0),
      mainVerticalStackView.safeBottom.constraint(lessThanOrEqualTo: mainContainerView.safeBottom, constant: -20.0)
    ])
    
    NSLayoutConstraint.activate([
      resolveButton.heightAnchor.constraint(equalToConstant: 44.0),
      cantResolveButton.heightAnchor.constraint(equalToConstant: 44.0),
      buttonStackView.safeTop.constraint(equalTo: mainContainerView.safeBottom, constant: 15.0),
      buttonStackView.safeLeading.constraint(equalTo: mainContainerView.safeLeading),
      buttonStackView.safeTrailing.constraint(equalTo: mainContainerView.safeTrailing)
    ])
    
    NSLayoutConstraint.activate([
      backgroundImage.safeTop.constraint(equalTo: mainContainerView.safeTop),
      backgroundImage.safeLeading.constraint(equalTo: mainContainerView.safeLeading),
      backgroundImage.safeTrailing.constraint(equalTo: mainContainerView.safeTrailing),
      backgroundImage.safeBottom.constraint(equalTo: mainContainerView.safeBottom)
    ])
  }
  
  func addTaskStatusImageView(_ viewModel: TaskDetailsViewModel) {
    
    var imageName: String?
    
    if viewModel.taskStatus == .resolved {
      imageName = "sign_resolved"
    } else if viewModel.taskStatus == .unResolved {
      imageName = "unresolved_sign"
    }
    
    taskStatusImageView.image = UIImage(named: imageName ?? "")
    
    view.addSubview(taskStatusImageView)
    
    NSLayoutConstraint.activate([
      taskStatusImageView.safeTop.constraint(equalTo: mainContainerView.safeBottom, constant: 50.0),
      taskStatusImageView.safeLeading.constraint(equalTo: mainContainerView.safeLeading),
      taskStatusImageView.safeTrailing.constraint(equalTo: mainContainerView.safeTrailing)
    ])
  }
}

extension TaskDetailsViewController {
  
  // Fetch task details from the interactor
  func fetchData() {
    interactor?.getDetails()
  }
  
  @objc func backButtonTapped() {
    self.navigationController?.popViewController(animated: true)
  }
  
  @objc func resolveButtonTapped() {
    interactor?.markResolved()
  }
  
  @objc func cantResolveButtonTapped() {
    interactor?.markUnResolved()
  }
}

// Extension to conform to TaskDetailsViewProtocol
extension TaskDetailsViewController: TaskDetailsViewProtocol {
  
  func populateTaskDetails(_ viewModel: TaskDetailsViewModel) {
    taskDescriptionLabel.text = viewModel.taskDescription
    taskTitleLabel.text = viewModel.title
    dueDateValueLabel.text = viewModel.formattedDueDate
    daysLeftValueLabel.text = viewModel.daysLeft
    
    taskStatusLabel.textColor = SmartTasksUI.Colors.yellowBackgroundColor
    
    taskStatusLabel.text = "Unresolved"
    
    if viewModel.taskStatus == .resolved {
      buttonStackView.isHidden = true
      taskStatusLabel.text = "Resolved"
      addTaskStatusImageView(viewModel)
    } else if viewModel.taskStatus == .unResolved {
      buttonStackView.isHidden = true
      addTaskStatusImageView(viewModel)
    }
  }
}
