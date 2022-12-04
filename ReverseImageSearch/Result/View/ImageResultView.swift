//
//  ImageResultView.swift
//  ReverseImageSearch
//
//  Created by DON on 11/21/22.
//

import SwiftUI

struct ImageResultView: View {
    let image: ImageResultsModel
    var body: some View {
        VStack{
            Text(image.title)
        }
    }
}

//struct ImageResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageResultView()
//    }
//}
