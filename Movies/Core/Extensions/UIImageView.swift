//
//  ImageView.swift
//  Movies

//
//  Created by Anas on 19/7/2022.
//

import UIKit

extension UIImageView {
    func load(urlString: String) {
        guard let url = URL(string: urlString) else {
            self.image = nil
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
    func load(urlString: String, completion: @escaping (_ image: UIImage,
                                                        _ loadedtImagePath: String) -> ()) {
        guard let url = URL(string: urlString) else {
            self.image = nil
            return
        }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(image, urlString)
                    }
                }
            }
        }
    }
}
