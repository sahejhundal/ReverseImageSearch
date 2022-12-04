//
//  CameraView.swift
//  ReverseImageSearch
//
//  Created by DON on 11/20/22.
//

import SwiftUI

struct CameraView: View {
    @StateObject var vm = CameraViewModel()
    @State var isPickerShowing = false
    var body: some View {
        if vm.loading != ""{
            Text("Scanning image...")
        }
        
        else if vm.isResultsShowing{
            VStack{
                ResultView(result: vm.result)//, isResultsShowing: $vm.isResultsShowing)
            }
            .onAppear{
//                vm.pullSample()
            }
        }
        
        else{
            
            GeometryReader{ geometry in
                ZStack{
                    VStack{
                        if (vm.photoFromLibrary == nil){
                            CameraPreview(camera: vm)
                            //                        Color.black
                        }
                        else{
                            Image(uiImage: vm.photoFromLibrary!)
                                .frame(width: geometry.size.width, height: geometry.size.height/2)
                            
                        }
                    }
                    .ignoresSafeArea(.all)
                    VStack{
                        Spacer()
                        HStack{
                            if vm.isTaken || vm.photoFromLibrary != nil{
                                isTakenUIView(vm: vm)
                            }
                            else{
                                ShutterButtonView(vm: vm)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
            }
            .onAppear{
                vm.Check()
//                vm.pullSample()
                //            vm.foo()
            }
            .sheet(isPresented: $isPickerShowing) {
                ImagePicker(selectedImage: $vm.photoFromLibrary, isPickerShowing: $isPickerShowing, sourcetype: .photoLibrary)
            }
            .onChange(of: vm.isResultsShowing) { newValue in
                if newValue == false{
                    withAnimation {
                        vm.reTake()
                    }
                }
            }
        }
    }
}
//
//struct CameraView_Previews: PreviewProvider {
//    static var previews: some View {
//        CameraView()
//    }
//}
