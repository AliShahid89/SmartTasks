//
//  TasksPresenter.swift
//  SmartTasks
//
//  Created by Ali Shahid on 09/06/2024.
//

import Foundation

struct TasksPresenter {
  // MARK: - Properties
  weak var view: TasksViewProtocol?
  private(set) var viewModels = [TaskViewModel]()
  
  /// A date formatter for converting between string and Date representations.
  private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
  }()
}

extension TasksPresenter: TasksPresenterProtocol {
  
  // MARK: - Data Formatting
  mutating func formatData(selectedDate: Date, tasks: [Task]?) {
    viewModels.removeAll()
    
    let formattedTargetDate = formatTargetDate(selectedDate)
    
    guard let tasks = tasks, !tasks.isEmpty else {
      view?.noTasksForToday(targetDate: formattedTargetDate)
      return
    }
    
    viewModels = tasks.compactMap { TaskViewModel(task: $0) }
    view?.populateTasks(targetDate: formattedTargetDate, viewModels: viewModels)
  }
}

private extension TasksPresenter {
  
  // MARK: - Target Date Formatting
  func formatTargetDate(_ date: Date) -> String {
    let calendar = Calendar.current
    
    if calendar.isDateInToday(date) {
      return "Today"
    } else {
      dateFormatter.dateFormat = "MMM dd yyyy"
      return dateFormatter.string(from: date)
    }
  }
}
