//
//  ShutterButtonView.swift
//  ReverseImageSearch
//
//  Created by DON on 11/29/22.
//

import SwiftUI

struct CameraOverlayView: View {
    @Binding var isCameraShowing: Bool
    @Binding var isPickerShowing: Bool
    
    var body: some View {
        HStack {
            Spacer()
            VStack(){
                Spacer()
                VStack(spacing: 10){
                    Button {
                        isCameraShowing = true
                    } label: {
                        Image(systemName: "camera")
                    }
                    .padding(15)
                    .background(.white)
                    .clipShape(Circle())
                    .shadow(radius: 5)
                    Button {
                        isPickerShowing = true
                    } label: {
                        Image(systemName: "photo")
                    }
                    .padding(15)
                    .background(.white)
                    .clipShape(Circle())
                    .shadow(radius: 5)
                }
                .foregroundColor(.blue)
                .font(.system(size: 30))
//                .padding(.vertical, 8)
//                .padding(.horizontal, 3)
//                .background(.white)
//                .clipShape(Capsule())
//                .shadow(radius: 5)
            }
            .padding(.bottom, 80)
            .padding(.trailing)
        }
    }
}
