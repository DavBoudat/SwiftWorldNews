//
//  SourcesCoreData.swift
//  WorldNews
//
//  Created by David on 03/06/2018.
//  Copyright © 2018 ynov. All rights reserved.
//

import Foundation
import CoreData

struct CoreDataHelper {
    let context : NSManagedObjectContext
    
    init(context : NSManagedObjectContext) {
        self.context = context
    }
    
    func GetEnabledSources(predicate : NSPredicate) -> [Source] {
        var sources = [Source]()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Sources")
        request.predicate = predicate
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let identifier = data.value(forKey: "identifier") as! String
                let name = data.value(forKey: "name") as! String
                let isEnabled = data.value(forKey: "isEnabled") as! Bool
                sources.append(Source(id: identifier, name: name, isEnabled: isEnabled))
            }
        } catch {
            fatalError("Cannot request Sources")
        }
        
        return sources
    }
    
    func saveSource(_ source : Source) {
        let entity = NSEntityDescription.entity(forEntityName: "Sources", in: context)
        let newSource = NSManagedObject(entity: entity!, insertInto: context)
        newSource.setValue(source.id, forKey: "identifier")
        newSource.setValue(source.name, forKey: "name")
        newSource.setValue(source.isEnabled, forKey: "isEnabled")
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func emptyCoreData() {
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Sources")
            let objects = try context.fetch(request) as! [NSManagedObject]
            for object in objects {
                context.delete(object)
            }
        } catch {
            print("Failed delete")
        }
    }
}
