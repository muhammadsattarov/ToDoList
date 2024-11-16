//
//  Note+CoreDataProperties.swift
//  iToDoList
//
//  Created by user on 25/08/24.
//
//

import UIKit
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: UUID!
    @NSManaged public var text: String!
    @NSManaged public var lastUpdated: Date!

  var title: String {
    return text?.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).first ?? "" // returns the first line of the text
  }

  var desc: String {
    var lines = text?.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
    lines?.removeFirst()
    return "\(lastUpdated?.format() ?? "")  \(lines?.first ?? "")" // return second line
  }
}

extension Note : Identifiable {}
