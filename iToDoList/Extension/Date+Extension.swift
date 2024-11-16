//
//  Date+Extension.swift
//  iToDoList
//
//  Created by user on 26/08/24.
//

import Foundation

extension Date {
  func format() -> String {
    let formatter = DateFormatter()
    if Calendar.current.isDateInToday(self) {
      formatter.dateFormat = "HH:mm"
    } else {
      formatter.dateFormat = "dd/MM/yy"
    }
    return formatter.string(from: self)
  }
}
