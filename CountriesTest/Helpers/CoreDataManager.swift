//
//  CoreDataManager.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//

import UIKit
import CoreData

/// Singleton class responsible for managing Core Data operations
final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    private init() {
        container = NSPersistentContainer(name: "CountriesTest")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("❌ Error loading Core Data: \(error.localizedDescription)")
            }
        }
        context = container.viewContext
    }
    
    // MARK: - Image Management
    
    /// Fetches an image from Core Data by its unique identifier.
    /// - Parameter id: The unique identifier for the image.
    /// - Returns: The corresponding `UIImage` or `nil` if not found.
    func fetchImage(id: String) -> UIImage? {
        let request: NSFetchRequest<ImageEntity> = ImageEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            guard let imageData = try context.fetch(request).first?.data,
                  let outputImage = UIImage(data: imageData) else {
                return nil
            }
            return outputImage
        } catch {
            print("❌ Error fetching image: \(error.localizedDescription)")
            return nil
        }
    }
    
    /// Saves an image to Core Data.
    /// - Parameters:
    ///   - image: The `UIImage` to save.
    ///   - id: The unique identifier for the image.
    func saveImage(image: UIImage, id: String) {
        guard let data = image.pngData() else { return }
        
        let imageEntity = ImageEntity(context: context)
        imageEntity.data = data
        imageEntity.id = id
        
        do {
            try context.save()
            print("✅ Image saved successfully with ID: \(id)")
        } catch {
            print("❌ Failed to save image: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Country Management
    
    /// Saves a country to Core Data.
    /// - Parameter country: The `CountryCacheable` instance to save.
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
        print("✅ Country '\(country.name)' saved successfully.")
    }
    
    /// Retrieves all saved countries from Core Data.
    /// - Returns: An array of `CountryCacheable` instances or `nil` if no data exists.
    func retrieveSavedCountries() throws -> [CountryCacheable]? {
        let request: NSFetchRequest<CountryCacheableEntity> = CountryCacheableEntity.fetchRequest()
        let results = try context.fetch(request)
        
        let output = results.compactMap { CountryCacheable(cacheableEntity: $0) }
        return output.isEmpty ? nil : output
    }
    
    /// Checks if a country exists in Core Data.
    /// - Parameter countryName: The name of the country to check.
    /// - Returns: `true` if the country exists, otherwise `false`.
    func containsCountry(countryName: String) throws -> Bool {
        let request: NSFetchRequest<CountryCacheableEntity> = CountryCacheableEntity.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", countryName)
        
        return try context.count(for: request) > 0
    }
    
    /// Deletes a country from Core Data by its name.
    /// - Parameter countryName: The name of the country to delete.
    func deleteCountry(countryName: String) throws {
        let request: NSFetchRequest<CountryCacheableEntity> = CountryCacheableEntity.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", countryName)
        
        let result = try context.fetch(request)
        
        if result.isEmpty {
            print("⚠️ No country found with name '\(countryName)' to delete.")
            return
        }
        
        result.forEach { context.delete($0) }
        try context.save()
        print("✅ Country '\(countryName)' deleted successfully.")
    }
}
