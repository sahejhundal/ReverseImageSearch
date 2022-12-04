//
//  isTakenUIView.swift
//  ReverseImageSearch
//
//  Created by DON on 11/29/22.
//

import SwiftUI

struct isTakenUIView: View {
    @ObservedObject var vm : CameraViewModel
    
    var body: some View {
        HStack{
            Button {
                if !vm.isSaved{
                    Task{
                        await vm.search()
                    }
                }
            } label: {
                Text("Search")
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .padding(.vertical,10)
                    .padding(.horizontal,20)
                    .background(Color.white)
                    .clipShape(Capsule())
            }
            Spacer()
            Button {
                vm.reTake()
            } label: {
                Text("Retake")
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .padding(.vertical,10)
                    .padding(.horizontal,20)
                    .background(Color.white)
                    .clipShape(Capsule())
            }
        }
    }
}
