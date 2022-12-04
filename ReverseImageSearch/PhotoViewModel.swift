//
//  PhotoViewModel.swift
//  ReverseImageSearch
//
//  Created by DON on 11/19/22.
//

import Foundation
import UIKit

class PhotoViewModel: ObservableObject{
    func converttoBASE64(){//image: UIImage){
        let image = UIImage(systemName: "house")
        let imageData: NSData = image!.pngData()! as NSData
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        print(strBase64)
    }
    
    func uploadPhoto(){
        let image = UIImage(systemName: "house")
        let imageData: NSData = image!.pngData()! as NSData
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        let baseURL = "https://freeimage.host/api/1/upload/"
        let apiKey = "6d207e02198a847aa98d0a2a901485a5"
        let parameters = "?key=\(apiKey)&source=\(strBase64)&format=json"
        let myurl = "https://freeimage.host/api/1/upload/?key=6d207e02198a847aa98d0a2a901485a5"
        let finalURL = baseURL + parameters
        let urlb = URL(string: baseURL)
        let url = URL(string: myurl) ?? urlb
        var request = URLRequest(url: url ?? urlb!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let encoded = try? JSONEncoder().encode(strBase64)
        URLSession.shared.uploadTask(with: request, from: encoded){ data,response,err  in
            print(response as Any)
            if let err = err{
                print(err)
                return
            }
            guard let data = data else{ return }
            print(data, String(data: data, encoding: .utf8) ?? "unknown encoding")
        }.resume()
        print("Second\n\n")
        URLSession.shared.dataTask(with: request) { data, response, err in
            print(response as Any)
            if let err = err{
                print(err)
                return
            }
            guard let data = data else{ return }
            print(data, String(data: data, encoding: .utf8) ?? "unknown encoding")
        }.resume()
    }
}
