//
//  ResultParentView.swift
//  ReverseImageSearch
//
//  Created by DON on 11/29/22.
//

import SwiftUI

struct ResultParentView: View{
    @ObservedObject var resultVM : ResultViewModel
    @State var photoTook = false
    var body: some View{
        VStack{
            if resultVM.loading != ""{
                ProgressView()
                Text(resultVM.loading)
            }
            else if resultVM.result.search_metadata.id == "" && resultVM.photo == nil{
                BlankResultView(isCameraShowing: $resultVM.isCameraShowing, isPickerShowing: $resultVM.isPickerShowing)
            }
            else{
                ZStack{
                    ResultView(result: resultVM.result)
                    CameraOverlayView(isCameraShowing: $resultVM.isCameraShowing, isPickerShowing: $resultVM.isPickerShowing)
                }
            }
        }
        .ignoresSafeArea(.all)
        .onChange(of: resultVM.photo, perform: { newValue in
            guard newValue != nil else {
                print("Null photo newValue")
                return
            }
//            resultVM.loadingBSbar()
            Task{
                await resultVM.search()
            }
            //resultVM.pullSample()
        })
//        .onAppear{
//            resultVM.pullSample()
//        }
        .sheet(isPresented: $resultVM.isCameraShowing) {
            CustomCameraView(capturedImage: $resultVM.photo)
        }
        .sheet(isPresented: $resultVM.isPickerShowing) {
            ImagePicker(selectedImage: $resultVM.photo, isPickerShowing: $resultVM.isPickerShowing, sourcetype: .photoLibrary)
        }
    }
}
//
//struct ResultParentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultParentView()
//    }
//}
