//
//  TaskDetailsPresenter.swift
//  SmartTasks
//
//  Created by Ali Shahid on 09/06/2024.
//

struct TaskDetailsPresenter {
  // MARK: - Properties
  weak var view: TaskDetailsViewProtocol?
}

extension TaskDetailsPresenter: TaskDetailsPresenterProtocol {
  
  // MARK: - Data Formatting
  mutating func formatData(_ task: Task) {
    let viewModel = TaskDetailsViewModel(task: task)
    view?.populateTaskDetails(viewModel)
  }
}
