//
//  CoreDataManager.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//

import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    private init() {
        container = NSPersistentContainer(name: "CountriesTest")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading Core Data, \(error.localizedDescription)")
            }
        }
        context = container.viewContext
    }
    
    func fetchImage(id: String) -> UIImage? {
        let request = NSFetchRequest<ImageEntity>(entityName: "ImageEntity")
        request.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let imageEntity = try context.fetch(request)
            guard let imageData = imageEntity.first?.data else {return nil}
            guard let outputImage = UIImage(data: imageData) else {return nil}
            return outputImage
        } catch let error {
            print("Error getting image from core data, \(error.localizedDescription)")
            return nil
        }
    }
    
    func saveImage(image: UIImage, id: String) {
        guard let data = image.pngData() else {return}
        let imageEntity = ImageEntity(context: context)
        imageEntity.data = data
        imageEntity.id = id
        
        do {
            try context.save()
            print("Image saved successfully with ID: \(id)")
        } catch let error {
            print("Failed to save image: \(error.localizedDescription)")
        }
    }
    
    func saveCountry(country: CountryCacheable) throws {
        
        let countryEntity = CountryCacheableEntity(context: context)
        countryEntity.area = country.area
        countryEntity.capital = country.capital
        countryEntity.currencyString = country.currencyString
        countryEntity.flagEmoji = country.flagEmoji
        countryEntity.flagPng = country.flagPng
        countryEntity.latitude = country.latitude
        countryEntity.longitude = country.longitude
        countryEntity.name = country.name
        countryEntity.nameLocalized = country.nameLocalized
        countryEntity.population = Int32(country.population)
        countryEntity.timeZones = country.timeZones
        countryEntity.continents = country.continents.joined(separator: ",")
        try context.save()
        }
    
    
    func retrieveSavedCountries() throws -> [CountryCacheable]? {
        let request = NSFetchRequest<CountryCacheableEntity>(entityName: "CountryCacheableEntity")
        let result = try context.fetch(request)
        let output = result.map { cacheableEntity in
            return CountryCacheable(cacheableEntity: cacheableEntity)
        }
        
        var filteredOutput = [CountryCacheable]()
        
        for country in output {
            if let country = country {
                filteredOutput.append(country)
            }
        }
        
        if filteredOutput.count == 0 {
            return nil
        } else {
            return filteredOutput
        }
        
    }
    
    func containsCountry(countryName: String) throws -> Bool {
        let request = NSFetchRequest<CountryCacheableEntity>(entityName: "CountryCacheableEntity")
        request.predicate = NSPredicate(format: "name == %@", countryName)

        let count = try context.count(for: request)
        return count > 0
    }
    
    
    func deleteCountry(countryName: String) throws {
        let request = NSFetchRequest<CountryCacheableEntity>(entityName: "CountryCacheableEntity")
        request.predicate = NSPredicate(format: "name == %@", countryName)
        let result = try context.fetch(request)
        
        for countryToDelete in result {
            context.delete(countryToDelete)
        }
        
        try context.save()
//        if let countryToDelete = result.first {
//            
//            
//        }
    }
}
