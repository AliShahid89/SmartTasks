//
//  TasksInteractor.swift
//  SmartTasks
//
//  Created by Ali Shahid on 08/06/2024.
//

import Foundation

enum FetchDate {
  case current
  case next
  case previous
}

final class TasksInteractor {
  
  private var selectedDate = Date()
  private var tasks: [Task]?
  
  private var tasksWorker: TasksWorkerProtocol
  var presenter: TasksPresenterProtocol?
  
  private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
  }()
  
  init(tasksWorker: TasksWorkerProtocol = TasksWorker()) {
    self.tasksWorker = tasksWorker
  }
}

extension TasksInteractor: TasksInteractorProtocol {
  
  func fetchAllTasks() {
    selectedDate = Date()
    
    tasksWorker.fetchTasks { [weak self] tasksResponse in
      self?.tasks = tasksResponse.tasks
      self?.sendTasksFor(self?.selectedDate ?? Date())
    }
  }
  
  func fetchTasksForDate(_ fetchDate: FetchDate) {
    switch fetchDate {
    case .current:
      selectedDate = Date()
    case .next:
      selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate)!
    case .previous:
      selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate)!
    }
    
    sendTasksFor(selectedDate)
  }
  
  private func sendTasksFor(_ selectedDate: Date) {
    guard let tasks, !tasks.isEmpty else {
      presenter?.formatData(selectedDate: selectedDate, tasks: [])
      return
    }
    
    // Filter tasks by targetDate
    let filteredTasks = tasks.filter { task in
      guard let targetDateString = task.targetDate,
            let targetDate = dateFormatter.date(from: targetDateString) else {
        return false // Exclude tasks with invalid or missing targetDate
      }
      
      return Calendar.current.isDate(targetDate, inSameDayAs: selectedDate)
    }
    
    // Sort filtered tasks by priority
    let sortedTasks = filteredTasks.sorted(by: { $0.priority ?? 0 > $1.priority ?? 0 })
    
    // Pass filtered tasks to the presenter
    presenter?.formatData(selectedDate: selectedDate, tasks: sortedTasks)
  }
}
