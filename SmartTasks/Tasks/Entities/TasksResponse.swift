//
//  TasksResponse.swift
//  SmartTasks
//
//  Created by Ali Shahid on 09/06/2024.
//

enum TaskStatus {
  case none
  case resolved
  case unResolved
}

struct TasksResponse: Codable {
  let tasks: [Task]?
}

struct Task: Codable {
  let id, targetDate: String?
  let dueDate: String?
  let title, description: String?
  let priority: Int?
  var taskStatus: TaskStatus = .none
  
  enum CodingKeys: String, CodingKey {
    case id
    case targetDate = "TargetDate"
    case dueDate = "DueDate"
    case title = "Title"
    case description = "Description"
    case priority = "Priority"
  }
}
