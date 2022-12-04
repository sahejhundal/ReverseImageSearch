//
//  CameraViewModel.swift
//  ReverseImageSearch
//
//  Created by DON on 11/20/22.
//

import SwiftUI
import AVFoundation
import UIKit

struct CameraPreview: UIViewRepresentable{
    @ObservedObject var camera : CameraViewModel
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame
        
        //
        camera.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)
        camera.session.startRunning()
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //
    }
}

final class CameraViewModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var result: ResultModel = .new
    @Published var isTaken = false
    @Published var alert = false
    @Published var session = AVCaptureSession()
    @Published var output = AVCapturePhotoOutput()
    @Published var preview : AVCaptureVideoPreviewLayer!
    @Published var isSaved = false
    @Published var picData = Data(count: 0)
    @Published var imageURL = ""
    @Published var loading = ""
    @Published var photoFromLibrary : UIImage?
    @Published var isResultsShowing = false
    @Published var isPickerShowing = false
    
    let useruuid = UIDevice.current.identifierForVendor!.uuidString
    
    func convertFirestoreURLtoImageServerURL(url: String) -> String{
        var newString = url.replacingOccurrences(of: "%2F", with: "/")
        newString = newString.replacingOccurrences(of: "firebasestorage", with: "storage")
        newString = newString.replacingOccurrences(of: "/v0/b/", with: "/")
        newString = newString.replacingOccurrences(of: "appspot.com/o/", with: "appspot.com/")
        return newString
    }
    
    func Check(){
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .authorized:
            // set up
            self.setUp()
            return
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { status in
                if status{
                    self.setUp()
                }
            }
            return
        case .denied:
            self.alert.toggle()
            return
        default:
            return
        }
    }
    
    func setUp(){
        do{ // set configs
            self.session.beginConfiguration()
            let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back)
            let input = try AVCaptureDeviceInput(device: device!)
            if self.session.canAddInput(input){
                self.session.addInput(input)
            }
            if self.session.canAddOutput(self.output){
                self.session.addOutput(self.output)
            }
            self.session.commitConfiguration()
        } catch{
            print(error.localizedDescription)
        }
    }
    
    func takePic(){
        DispatchQueue.global(qos: .background).async {
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            self.session.stopRunning()
            
            DispatchQueue.main.async {
                withAnimation {
                    self.isTaken.toggle()
                }
            }
        }
    }
    
    func reTake(){
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
            DispatchQueue.main.async {
                withAnimation {
                    self.isTaken = false
                    self.photoFromLibrary = nil
                }
            }
        }
    }
    
    func doSerpSearch(imageurl: String){
//        print("image url is \(imageurl)")
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
    
    // https://firebasestorage.googleapis.com:443/v0/b/reverseimagesearch-5c963.appspot.com/o/images/BAEEF111-BF80-4702-B728-1BF9697BAC0B/gimqb?alt=media&token=b7cf7894-8478-4e28-8607-e187086d7a22
    
    // https://firebasestorage.googleapis.com:443/v0/b/reverseimagesearch-5c963.appspot.com/o/images/BAEEF111-BF80-4702-B728-1BF9697BAC0B/gimqb?alt=media
    
    func parse(data: Data){
        do{
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(ResultModel.self, from: data)
            self.result = decoded
            self.loading = "Searching the web..."
            self.isResultsShowing = true
            print("result object made")
        }
        catch{
            print("Error converting JSON to data")
            print(error)
            return
        }
    }
    
    func search() async {
        DispatchQueue.main.async{
            self.loading = "Scanning image..."
            self.isSaved = true
        }
        await uploadPicture()
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
        let word = randomWord()
        if let image = photoFromLibrary{
            FirebaseManager.shared.storage.reference().child("images/\(useruuid)/\(word).jpg").putData(image.compressImage()) { metadata, error in
                guard error == nil else{ return }
                FirebaseManager.shared.storage.reference().child("images/\(self.useruuid)/\(word).jpg").downloadURL { url, error in
                    guard let url = url else{
                        print("No download url")
                        return
                    }
                    DispatchQueue.main.async{
                        let baseURL = "https://reverseimageimageserver.herokuapp.com/reverseimage/"
                        let newString = self.convertFirestoreURLtoImageServerURL(url: url.absoluteString)
//                        newString = baseURL + newString
                        if newString != ""{
                            self.imageURL = newString
                            self.loading = ""
                            print("Image uploaded from library! URL is \(self.imageURL)")
//                            self.doSerpSearch(imageurl: self.imageURL)
                        }
                    }
                }
            }
        }
        else {
            FirebaseManager.shared.storage.reference().child("images/\(useruuid)/\(word).jpg").putData(picData) { metadata, error in
                guard error == nil else{ return }
                FirebaseManager.shared.storage.reference().child("images/\(self.useruuid)/\(word).jpg").downloadURL { url, error in
                    guard let url = url else{
                        print("No download url")
                        return
                    }
                    DispatchQueue.main.async{
                        var newString = self.convertFirestoreURLtoImageServerURL(url: url.absoluteString)
                        if newString != ""{
                            self.imageURL = newString
//                            self.loading = ""
                            print("Image uploaded from library! URL is \(self.imageURL)")
//                            self.doSerpSearch(imageurl: self.imageURL)
                        }
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
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if error != nil{
            print("Error: \(error?.localizedDescription ?? "error here")")
            return
        }
        
        print("pic taken")
        
        guard let imageData = photo.fileDataRepresentation() else{
            print("No image data from capture")
            return
        }
        self.photoFromLibrary = UIImage(data: imageData)
        
        self.picData = imageData
    }
}
