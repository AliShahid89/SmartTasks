//
//  TaskDetailsInteractor.swift
//  SmartTasks
//
//  Created by Ali Shahid on 09/06/2024.
//

final class TaskDetailsInteractor {
  
  private var task: Task
  
  var presenter: TaskDetailsPresenterProtocol?
  
  init(task: Task) {
    self.task = task
  }
}

extension TaskDetailsInteractor: TaskDetailsInteractorProtocol {
  
  func markResolved() {
    task.taskStatus = .resolved
    presenter?.formatData(task)
  }
  
  func markUnResolved() {
    task.taskStatus = .unResolved
    presenter?.formatData(task)
  }
  
  func getDetails() {
    presenter?.formatData(self.task)
  }
}

