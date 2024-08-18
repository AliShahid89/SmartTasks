//
//  TaskTableViewCell.swift
//  SmartTasks
//
//  Created by Ali Shahid on 08/06/2024.
//

import UIKit

final class TaskTableViewCell: UITableViewCell {
  
  // Main container view with rounded corners and a white background
  private lazy var mainContainerView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 5.0
    view.clipsToBounds = true
    view.backgroundColor = .white
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  // Main vertical stack view for arranging subviews vertically
  private lazy var mainVerticalStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.spacing = 10.0
    return stackView
  }()
  
  // Main horizontal stack view for arranging subviews horizontally
  private lazy var mainHorizontalStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.spacing = 10.0
    return stackView
  }()
  
  // Wanted to make a separate component for dueDateStackView & daysLeftStackView since they are being used in details section as well. Couldn't do as per time constraint.
  
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
    let label = CustomLabel(text: "Task Title", font: SmartTasksUI.font(type: .bold, size: .medium), textColor: SmartTasksUI.Colors.redColor)
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
  
  // Initializer for creating the cell programmatically
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.contentView.backgroundColor = .clear
    self.backgroundColor = .clear
    setupViews()
  }
  
  // Required initializer for decoding the cell (not implemented)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // Method to reset the cell's views before reuse
  override func prepareForReuse() {
    resetViews()
  }
  
  // Method to configure the cell with a TaskViewModel
  func setup(_ viewModel: TaskViewModel) {
    taskTitleLabel.text = viewModel.title
    daysLeftValueLabel.text = viewModel.daysLeft
    
    dueDateStackView.isHidden = true
    daysLeftStackView.isHidden = true
    
    if let formattedDueDate = viewModel.formattedDueDate {
      dueDateStackView.isHidden = false
      daysLeftStackView.isHidden = false
      dueDateValueLabel.text = formattedDueDate
    }
  }
}

// Private extension for setup and reset methods
private extension TaskTableViewCell {
  
  // Method to setup and layout the views
  func setupViews() {
    contentView.addSubview(mainContainerView)
    mainContainerView.addSubview(mainVerticalStackView)
    
    mainVerticalStackView.addArrangedSubview(taskTitleLabel)
    mainVerticalStackView.addArrangedSubview(UIView.customSeparatorView)
    
    dueDateStackView.addArrangedSubview(dueDateLabel)
    dueDateStackView.addArrangedSubview(dueDateValueLabel)
    
    mainVerticalStackView.addArrangedSubview(dueDateStackView)
    mainHorizontalStackView.addArrangedSubview(dueDateStackView)
    mainHorizontalStackView.addArrangedSubview(UIView.spacer)
    
    daysLeftStackView.addArrangedSubview(daysLeftLabel)
    daysLeftStackView.addArrangedSubview(daysLeftValueLabel)
    mainHorizontalStackView.addArrangedSubview(daysLeftStackView)
    
    mainVerticalStackView.addArrangedSubview(mainHorizontalStackView)
    
    // Activate layout constraints for the views
    NSLayoutConstraint.activate([
      mainContainerView.safeTop.constraint(equalTo: contentView.safeTop, constant: 5.0),
      mainContainerView.safeLeading.constraint(equalTo: contentView.safeLeading, constant: 10.0),
      mainContainerView.safeTrailing.constraint(equalTo: contentView.safeTrailing, constant: -10.0),
      mainContainerView.safeBottom.constraint(equalTo: contentView.safeBottom, constant: -5.0),
      
      mainVerticalStackView.safeTop.constraint(equalTo: mainContainerView.safeTop, constant: 10.0),
      mainVerticalStackView.safeLeading.constraint(equalTo: mainContainerView.safeLeading, constant: 10.0),
      mainVerticalStackView.safeTrailing.constraint(equalTo: mainContainerView.safeTrailing, constant: -10.0),
      mainVerticalStackView.safeBottom.constraint(equalTo: mainContainerView.safeBottom, constant: -10.0)
    ])
  }
  
  // Method to reset the views to their default state
  func resetViews() {
    daysLeftValueLabel.text = ""
    dueDateValueLabel.text = ""
  }
}
