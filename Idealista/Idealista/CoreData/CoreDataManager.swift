//
//  CoreDataManager.swift
//  Idealista
//
//  Created by Conrado Capilla García on 27/11/24.
//

import Foundation
import CoreData
import UIKit

final class CoreDataManager {

    
    // MARK: - Singleton
    static let shared = CoreDataManager()
    private init() {}

    
    // MARK: - CoreData context
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    // MARK: - CRUD methods of ads list
    // save a new ad
    func saveAd(newAd: HomeAdListViewModel) {
        let ad = AdHomeList(context: self.context)
        ad.direction = newAd.direction
        ad.price = newAd.price
        ad.propertyCode = newAd.propertyCode
        ad.propertyType = newAd.propertyType
        self.saveContext()
    }

    // remove the selected ad
    func removeAd(_ ad: AdHomeList) {
        self.context.delete(ad)
        self.saveContext()
    }
    
    // remove all ads
    func deleteAllAds() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AdHomeList")
        do {
            let objects = try self.context.fetch(fetchRequest)
            for object in objects {
                if let objectToDelete = object as? NSManagedObject {
                    self.context.delete(objectToDelete)
                }
            }
            try self.context.save()
        } catch let error {
            print("Error al eliminar los objetos: \(error.localizedDescription)")
        }
    }


    // fetch all ads
    func fetchAds() -> [AdHomeList] {
        let fetchRequest: NSFetchRequest<AdHomeList> = AdHomeList.fetchRequest()
        do {
            let ads = try self.context.fetch(fetchRequest)
            for ad in ads {
                print(ad)
            }
            return ads
        } catch {
            print("Error fetch ads: \(error)")
            return []
        }
    }


    
    // MARK: - Private functions
    // Save context
    private func saveContext() {
        do {
            try context.save()
            print("Context saved successfully")
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
