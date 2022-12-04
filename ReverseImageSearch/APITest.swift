//
//  APITest.swift
//  ReverseImageSearch
//
//  Created by DON on 11/19/22.
//

import SwiftUI

struct APITest: View {
    let text = UIDevice.current.identifierForVendor!.uuidString
    var body: some View {
        Text(text)

    }
}

struct APITest_Previews: PreviewProvider {
    static var previews: some View {
        APITest()
    }
}
