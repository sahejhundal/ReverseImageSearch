//
//  CameraViewModel.swift
//  ReverseImageSearch
//
//  Created by DON on 11/20/22.
//

import SwiftUI
import AVFoundation
import UIKit


final class ResultViewModel: NSObject, ObservableObject{
    @Published var result: ResultModel = .new
    @Published var isTaken = false
    @Published var alert = false
    @Published var isSaved = false
    @Published var photo : UIImage?
    @Published var imageURL = ""
    @Published var loading = ""
    @Published var isResultsShowing = false
    @Published var isCameraShowing = false
    @Published var isPickerShowing = false
    
//    override init(){
//        super.init()
//        pullSample()
//    }
    
    let useruuid = UIDevice.current.identifierForVendor!.uuidString
    
    func convertFirestoreURLtoImageServerURL(url: String) -> String{
        var newString = url.replacingOccurrences(of: "%2F", with: "/")
        newString = newString.replacingOccurrences(of: "firebasestorage", with: "storage")
        newString = newString.replacingOccurrences(of: "/v0/b/", with: "/")
        newString = newString.replacingOccurrences(of: "appspot.com/o/", with: "appspot.com/")
        return newString
    }
    
    func doSerpSearch(imageurl: String){
//        print("image url is \(imageurl)")
        loading = "Searching the web..."
        let serpApiKey : String = "273c28c532edb78345d150bfa8543894d66eb93a79a0330f543e792a248d45ed"
//        let imageurl: String = "https://www.topgear.com/sites/default/files/2021/06/0x0-ModelSPLAID-1.jpg"
        let urls : String = "https://serpapi.com/search?api_key=\(serpApiKey)&engine=google_reverse_image&image_url=\(imageurl)"
//        print("final url is \(urls)")
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
                print(urls)
                print(data)
                self.parse(data: data)
            }
        }
        dataTask.resume()
    }
    
    func parse(data: Data){
        do{
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(ResultModel.self, from: data)
            self.result = decoded
            self.loading = ""
            self.isResultsShowing = true
            print("result object made")
        }
        catch{
            print("Error converting JSON to data")
            print(error)
            return
        }
    }
    
    func loadingBSbar() {
        DispatchQueue.main.async {
            Task{
                self.loading = "Scanning image"
                print(self.loading)
                try? await Task.sleep(nanoseconds: 2_000_000_000)
                self.loading = "Searching the web"
                try? await Task.sleep(nanoseconds: 2_000_000_000)
                self.loading = ""
                print(self.loading)
            }
        }
    }
    
    func search() async {
        DispatchQueue.main.async{
            self.loading = "Scanning image..."
            self.isSaved = true
            Task{
                await self.uploadPicture()
            }
        }
        
    }
    
    func randomWord() -> String{
        var x = "";
        for _ in 0..<5{
            let string = String(format: "%c", Int.random(in: 97..<123)) as String
            x+=string
        }
        return x
    }
    
    func uploadPicture() async {
        guard photo != nil else{
            print("Upload photo called but photo is nil")
            return
        }
        let word = randomWord()
        FirebaseManager.shared.storage.reference().child("images/\(useruuid)/\(word).jpg").putData(photo!.compressImage()) { metadata, error in
            guard error == nil else{ return }
            FirebaseManager.shared.storage.reference().child("images/\(self.useruuid)/\(word).jpg").downloadURL { url, error in
                guard let url = url else{
                    print("No download url")
                    return
                }
                DispatchQueue.main.async{
                    let newString = self.convertFirestoreURLtoImageServerURL(url: url.absoluteString)
                    if newString != ""{
                        self.imageURL = newString
                        self.loading = ""
                        print("Image uploaded from library! URL is \(self.imageURL)")
                        self.doSerpSearch(imageurl: self.imageURL)
                    }
                }
            }
        }
    }
    
    func pullSample(){
//        if let file = URL(string: "https://serpapi.com/searches/3af7f52b8bb69558/637c94ff96f5d736f4f874d8.json") // bad
        if let file = URL(string: "https://serpapi.com/searches/c06a9bfdc6ed6738/637bd186dc02f13070e26306.json") // good (plaid)
        {
            file.asyncDownload { data, response, error in
                guard let data = data else{
                    print("No data")
                    print(error?.localizedDescription ?? "Error")
                    return
                }
                do{
                    let decoder = JSONDecoder()
                    let decoded = try decoder.decode(ResultModel.self, from: data)
                    DispatchQueue.main.async {
                        self.result = decoded
                    }
                    print(decoded.search_information?.query_displayed as Any)
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
}



// https://firebasestorage.googleapis.com:443/v0/b/reverseimagesearch-5c963.appspot.com/o/images/BAEEF111-BF80-4702-B728-1BF9697BAC0B/gimqb?alt=media&token=b7cf7894-8478-4e28-8607-e187086d7a22

// https://firebasestorage.googleapis.com:443/v0/b/reverseimagesearch-5c963.appspot.com/o/images/BAEEF111-BF80-4702-B728-1BF9697BAC0B/gimqb?alt=media
