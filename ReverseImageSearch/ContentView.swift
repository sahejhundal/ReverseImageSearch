//
//  ContentView.swift
//  ReverseImageSearch
//
//  Created by DON on 11/19/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var resultVM = ResultViewModel()
    var body: some View {
        ResultParentView(resultVM: resultVM)
//        ResultViewCaller()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
