//
//  ImageCachedSDViewModel.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//

import SwiftUI
final class ImageCachedViewModel: ObservableObject {
    
    init() {
        self.image = UIImage(systemName: "ellipsis")!
    }
    
    @Published var image: UIImage
    
    func loadImage(urlString: String) {
        
        if let image = CoreDataManager.shared.fetchImage(id: urlString) {
            self.image = image
        } else {
            guard let url = URL(string: urlString) else {return}
            downloadImage(from: url) { image in
                if let image = image {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                    DispatchQueue.global().async {
                        CoreDataManager.shared.saveImage(image: image, id: urlString)
                    }
                }
            }
        }
        
        

        
    }
    

    private func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error downloading image: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Invalid image data")
                completion(nil)
                return
            }
            
            completion(image)
        }
        
        task.resume()
    }

    
}


