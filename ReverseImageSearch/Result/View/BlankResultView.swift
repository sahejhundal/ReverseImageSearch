//
//  BlankResultView.swift
//  ReverseImageSearch
//
//  Created by DON on 11/29/22.
//

import SwiftUI

struct BlankResultView: View {
    @Binding var isCameraShowing: Bool
    @Binding var isPickerShowing: Bool
    
    @State var bgColor: Color = .white
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea(.all)
            
            VStack(){
                Spacer()
                VStack {
                    Text("Reverse").textCase(.uppercase).foregroundColor(.white).font(.system(size: 30,weight: .black))
                    Text("Image").textCase(.uppercase).foregroundColor(.white).font(.system(size: 30,weight: .black))
                        .padding(.horizontal).border(.red)
                    Text("Search").textCase(.uppercase).foregroundColor(.white).font(.system(size: 30,weight: .black))
                }
                .shadow(color: .red, radius: 15)
                
                Spacer()
                HStack{
                    Button {
                        isCameraShowing = true
                    } label: {
                        Image(systemName: "camera.fill")
                    }
                    .padding(40)
                    Button {
                        isPickerShowing = true
                    } label: {
                        Image(systemName: "photo.fill")
                    }
                    .padding(40)
                }
                .foregroundColor(.white)
                .font(.system(size: 50))
                .padding(.vertical, 8)
                .padding(.horizontal, 1)
                .background(bgColor)
                .clipShape(Capsule())
                Spacer()
            }
            .padding(.bottom, 80)
            .padding(.trailing)
        }
        .onAppear{
            withAnimation(Animation.easeIn(duration: 2).delay(0.5)) {
                bgColor = .red
            }
        }
    }
}
//
//struct BlankResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        BlankResultView()
//    }
//}
