//
//  TaskDetailsViewModel.swift
//  SmartTasks
//
//  Created by Ali Shahid on 09/06/2024.
//

import Foundation

/// Represents a view model for displaying task detail information in the UI.
struct TaskDetailsViewModel {
  
  // MARK: - Private Properties
  
  /// The underlying Task data model.
  private let task: Task
  
  /// A date formatter for converting between string and Date representations.
  private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd" // Initial format for parsing the due date
    return formatter
  }()
  
  // MARK: - Initialization
  
  /// Initializes a TaskViewModel with a Task object.
  /// - Parameter task: The Task object containing the data to be displayed.
  init(task: Task) {
    self.task = task
  }
  
  // MARK: - Computed Properties
  
  /// The title of the task.
  var title: String? {
    return task.title
  }
  
  /// The description of the task.
  var taskDescription: String? {
    return task.description
  }
  
  /// The due date of the task, formatted as "MMM dd yyyy" (e.g., "Aug 31 2024").
  var formattedDueDate: String? {
    return task.dueDate?.getFormattedDate() ?? "None"
  }
  
  /// The number of days left until the task is due, or special strings for overdue/due today tasks.
  var daysLeft: String? {
    dateFormatter.dateFormat = "yyyy-MM-dd" // Reset the date formatter for parsing
    
    // Ensure the due date string is valid and can be converted to a Date
    guard let dueDateString = task.dueDate,
          let dueDate = dateFormatter.date(from: dueDateString) else {
      return "-"
    }
    
    let calendar = Calendar.current
    let components = calendar.dateComponents([.day], from: Date(), to: dueDate)
    
    // Calculate days remaining and format the result
    if let days = components.day {
      if days < 0 {
        return "Overdue"
      } else if days == 0 {
        return "Due Today"
      } else {
        return "\(days)" // Only the number, matching the design
      }
    } else {
      return "-" // Handle unexpected date calculation errors
    }
  }
  
  var taskStatus: TaskStatus {
    return task.taskStatus
  }
  
  // MARK: - Getters
  
  var taskEntity: Task {
    return task
  }
}
