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
    // check if ad is favorite
    func isFavoriteAdList(propertyCode: String) -> Bool {
        let fetchRequest: NSFetchRequest<AdHomeList> = AdHomeList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "propertyCode == %@", propertyCode)
        do {
            let results = try context.fetch(fetchRequest)
            return !results.isEmpty
        } catch {
            return false
        }
    }

    
    // save a new ad
    func saveAdList(newAd: HomeAdListViewModel, saved completion: (Bool) -> (Void)) {
        let ad = AdHomeList(context: self.context)
        ad.direction = newAd.direction
        ad.price = newAd.price
        ad.propertyCode = newAd.propertyCode
        ad.propertyType = newAd.propertyType
        ad.dataSaved = Date()
        do {
            try self.context.save()
            completion(true)
        } catch {
            completion(false)
        }
    }

    // remove the selected ad
    func removeAdList(propertyCode: String, removed completion: (Bool) -> (Void)) {
        let fetchRequest: NSFetchRequest<AdHomeList> = AdHomeList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "propertyCode == %@", propertyCode)
        do {
            guard let result = try self.context.fetch(fetchRequest).first else { return }
            self.context.delete(result)
            saveContext()
            completion(true)
        } catch {
            completion(false)
        }
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
    func fetchAds() {
        let fetchRequest: NSFetchRequest<AdHomeList> = AdHomeList.fetchRequest()
        do {
            let ads = try self.context.fetch(fetchRequest)
            for ad in ads {
                print("\n= = = = ")
                print(ad.propertyCode!)
                print("= = = = ")
            }
        } catch {
            print("Error fetch ads: \(error)")
        }
    }
    
    
    // MARK: - CRUD methods of ad detail
    // check if ad is favorite
    func isFavoriteAdDetail(propertyCode: String) -> Bool {
        let fetchRequest: NSFetchRequest<AdHomeDetail> = AdHomeDetail.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "adId == %@", propertyCode)
        return (try? context.fetch(fetchRequest))?.isEmpty == false
    }
    
    // save a new detail ad
    func saveAdDetail(newAd: HomeAdDetailViewModel, saved completion: (Bool) -> (Void)) {
        let ad = AdHomeDetail(context: self.context)
        ad.adId = Int16(newAd.adId)
        ad.price = newAd.price
        ad.propertyType = newAd.propertyType
        ad.dataSaved = Date()
        do {
            try self.context.save()
            completion(true)
        } catch {
            completion(false)
        }
    }
    
    // remove the selected ad
    func removeAdDetail(propertyCode: String, removed completion: (Bool) -> (Void)) {
        let fetchRequest: NSFetchRequest<AdHomeDetail> = AdHomeDetail.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "adId == %@", propertyCode)
        do {
            guard let result = try self.context.fetch(fetchRequest).first else { return }
            self.context.delete(result)
            saveContext()
            completion(true)
        } catch {
            completion(false)
        }
    }
    
    // remove all ads
    func deleteAllAdsDetail() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AdHomeDetail")
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
    func fetchAdsDetail() -> [AdHomeDetail] {
        let fetchRequest: NSFetchRequest<AdHomeDetail> = AdHomeDetail.fetchRequest()
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
