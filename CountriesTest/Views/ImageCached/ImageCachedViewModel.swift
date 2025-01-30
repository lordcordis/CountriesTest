//
//  ImageCachedSDViewModel.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//

import SwiftUI

// ViewModel for loading and caching images
final class ImageCachedViewModel: ObservableObject {
    
    // Initializer with default image (ellipsis icon)
    init() {
        self.image = UIImage(systemName: "ellipsis")!
    }
    
    @Published var image: UIImage // Published image to be observed by the view
    
    // Function to load image either from cache or URL
    func loadImage(urlString: String) {
        
        // Try fetching the image from Core Data cache
        if let image = CoreDataManager.shared.fetchImage(id: urlString) {
            self.image = image
        } else {
            guard let url = URL(string: urlString) else {return} // Validate URL
            downloadImage(from: url) { image in
                if let image = image {
                    // Update image on the main thread
                    DispatchQueue.main.async {
                        self.image = image
                    }
                    // Save the image in Core Data in the background
                    DispatchQueue.global().async {
                        CoreDataManager.shared.saveImage(image: image, id: urlString)
                    }
                }
            }
        }
    }
    
    // Helper function to download image from URL
    private func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error downloading image: \(error)") // Print error if any
                completion(nil)
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Invalid image data") // Print error if image data is invalid
                completion(nil)
                return
            }
            
            completion(image) // Return the downloaded image
        }
        
        task.resume() // Start the download task
    }
}
