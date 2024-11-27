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
    /// save a new ad
    func saveAd(newAd: HomeAdListViewModel) {
        let myAd = AdHomeList(context: self.context)
        myAd.titleAd = newAd.address
        myAd.descriptionAd = newAd.floor
        self.saveContext()
    }

    /// remove the selected ad
    func removeAd(_ ad: AdHomeList) {
        self.context.delete(ad)
        self.saveContext()
    }

    /// fetch all ads
    func fetchAds() -> [AdHomeList] {
        let fetchRequest: NSFetchRequest<AdHomeList> = AdHomeList.fetchRequest()
        do {
            return try self.context.fetch(fetchRequest)
        } catch {
            print("Error fetch ads: \(error)")
            return []
        }
    }

    // MARK: - Guardar contexto
    private func saveContext() {
        do {
            try context.save()
            print("Context saved successfully")
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
