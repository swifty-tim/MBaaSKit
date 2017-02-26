//
//  ImageView+Ext.swift
//  Pods
//
//  Created by Timothy Barnard on 26/02/2017.
//
//

import Foundation

public extension UIImageView {
    public func downloadedFrom( actInd: UIActivityIndicatorView, url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        actInd.startAnimating()
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
                actInd.stopAnimating()
            }
            }.resume()
    }
    public func downloadedFrom(  actInd: UIActivityIndicatorView, link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom( actInd: actInd, url: url, contentMode: mode)
    }
}
