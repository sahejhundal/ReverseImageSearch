//
//  Model.swift
//  JsonParser
//
//  Created by DON on 11/21/22.
//

import Foundation
import UIKit

final class ParserClass: ObservableObject{
    @Published var result : ResultModel = .new
    
    init(data: Data){
        self.convert(fromData: data)
    }
    
    func convert(fromData data: Data){
        do{
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(ResultModel.self, from: data)
            self.result = decoded
            print("result object made")
        }
        catch{
            print("Error converting JSON to data")
            print(error)
            return
        }
    }
    
    func goo(){
        if let file = URL(string: "https://serpapi.com/searches/c06a9bfdc6ed6738/637bd186dc02f13070e26306.json"){
            do {
                let data = try Data(contentsOf: file)
                print("data is", data)
                do{
                    let decoder = JSONDecoder()
                    let decoded = try decoder.decode(ResultModel.self, from: data)
                    self.result = decoded
//                    print(decoded.search_information.query_displayed)
//                    for i in decoded.image_results{
//                        print(i.title)
//                    }
                }
                catch{
                    print("Error converting JSON to data")
                    print(error)
                    return
                }
                
            } catch {
                fatalError("Couldn't load\(error)")
            }
        } else{
            print("url error")
        }
    }
    
    func convert(){
        if let file = URL(string: "https://serpapi.com/searches/c06a9bfdc6ed6738/637bd186dc02f13070e26306.json") {
            file.asyncDownload { data, response, error in
                guard let data = data else{
                    print("No data")
                    print(error?.localizedDescription ?? "Error")
                    return
                }
                do{
                    let decoder = JSONDecoder()
                    let decoded = try decoder.decode(ResultModel.self, from: data)
                    self.result = decoded
//                    print(decoded.search_information.query_displayed)
//                    for i in decoded.image_results{
//                        print(i.title)
//                    }
                }
                catch{
                    print("Error converting JSON to data")
                    print(error)
                    return
                }
            }
        } else {
            print("Invalid url")
            return
        }
    }
    
    func foo(){
        let serpApiKey : String = "273c28c532edb78345d150bfa8543894d66eb93a79a0330f543e792a248d45ed"
        let imageurl: String = "https://www.topgear.com/sites/default/files/2021/06/0x0-ModelSPLAID-1.jpg"
        let urls : String = "https://serpapi.com/search?api_key=\(serpApiKey)&engine=google_reverse_image&image_url=\(imageurl)"
        guard let url = URL(string: urls) else{
            print("No url")
            return
        }
        let urlRequest = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                print(data)
            }
        }
        dataTask.resume()
    }
}

extension URL {
    func asyncDownload(completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()) {
        URLSession.shared
            .dataTask(with: self, completionHandler: completion)
            .resume()
    }
}
