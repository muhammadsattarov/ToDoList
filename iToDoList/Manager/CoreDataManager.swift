//
//  CoreDataManager.swift
//  iToDoList
//
//  Created by user on 26/08/24.
//

import Foundation
import CoreData

class CoreDataManager {

  static let shared = CoreDataManager(modelName: "Note")

  let persistentContainer: NSPersistentContainer
  var viewContext: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  init(modelName: String) {
    persistentContainer = NSPersistentContainer(name: modelName)
  }

  func load(completion: (() -> Void)? = nil) {
    persistentContainer.loadPersistentStores { description, error in
      guard error == nil else {
        fatalError(error!.localizedDescription)
      }
      completion?()
    }
  }

  func save() {
    if viewContext.hasChanges {
      do {
        try viewContext.save()
      } catch {
        print("An error occurred while saving: \(error.localizedDescription)")
      }
    }
  }
}

// MARK: - Helper functions
extension CoreDataManager {
  func createNote() -> Note {
    let note = Note(context: viewContext)
    note.id = UUID()
    note.text = ""
    note.lastUpdated = Date()
    save()
    return note
  }

  func fetchNotes(filter: String? = nil) -> [Note] {
    let request: NSFetchRequest<Note> = Note.fetchRequest()
    let sortDescriptor = NSSortDescriptor(keyPath: \Note.lastUpdated, ascending: false)
    request.sortDescriptors = [sortDescriptor]
    if let filter = filter {
      let predicate = NSPredicate(format: "text contains[cd] %@", filter)
      request.predicate = predicate
    }
      return (try? viewContext.fetch(request)) ?? []
  }

  func deleteNote(_ note: Note) {
    viewContext.delete(note)
    save()
  }

  func createFetchResultController(filter: String? = nil) -> NSFetchedResultsController<Note> {
    let request: NSFetchRequest<Note> = Note.fetchRequest()
    let sortDescriptor = NSSortDescriptor(keyPath: \Note.lastUpdated, ascending: false)
    request.sortDescriptors = [sortDescriptor]
    if let filter = filter {
      let predicate = NSPredicate(format: "text contains[cd] %@", filter)
      request.predicate = predicate
    }
    return NSFetchedResultsController(fetchRequest: request,
                                      managedObjectContext: viewContext,
                                      sectionNameKeyPath: nil,
                                      cacheName: nil)
  }
}
