//
//  ShutterButtonView.swift
//  ReverseImageSearch
//
//  Created by DON on 11/29/22.
//

import SwiftUI

struct ShutterButtonView: View {
    @ObservedObject var vm : CameraViewModel
    var body: some View {
        HStack{
            Button {
                vm.takePic()
            } label: {
                ZStack{
                    Circle()
                        .fill(Color.white)
                        .opacity(0.5)
                        .frame(width: 60, height: 60)
                    Circle()
                        .stroke(Color.white,lineWidth: 2)
                        .frame(width: 70, height: 70)
                    HStack{
                        Button {
                            vm.isPickerShowing = true
                        } label: {
                            Image(systemName: "photo")
                        }
                        Spacer()
                    }
                    .font(.system(size: 30))
                    .padding(.leading, 30)
                    .foregroundColor(.gray)
                    
                }
            }
        }
    }
}
