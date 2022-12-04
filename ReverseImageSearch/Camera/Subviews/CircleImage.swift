//
//  CircleImage.swift
//  Restaurants
//
//  Created by DON on 10/18/22.
//

import SwiftUI

struct CircleImage: View {
    let url: String
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: url)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    
            } placeholder: {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
        .clipShape(Circle())
        .overlay{
            Circle().stroke(.white,lineWidth: 4)
        }
        .shadow(radius: 10)
           
    }
}

//struct CircleImage_Previews: PreviewProvider {
//    static var previews: some View {
//        CircleImage()
//    }
//}
