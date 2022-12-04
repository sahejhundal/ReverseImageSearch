//
//  ContentView.swift
//  JsonParser
//
//  Created by DON on 11/21/22.
//

import SwiftUI

struct ResultViewCaller: View{
    @ObservedObject var vm : CameraViewModel
    var body: some View{
        VStack{
            ResultView(result: vm.result)
        }.onAppear{
            vm.pullSample()
        }
    }
}

struct ResultView: View {
    let result: ResultModel
    
    var body: some View {
        NavigationView{
            ScrollView {
                HStack{
                    Text(result.search_information?.query_displayed ?? "resulting...").font(.system(size: 35,weight: .bold))
                }
                if (result.image_sizes != nil){
                    if(!result.image_sizes!.isEmpty){
                        Link("Exact image matches", destination: URL(string: (result.image_sizes?.first!.link)!)!)
                            .font(.system(size: 16,weight: .bold))
                            .foregroundColor(.red)
                    }
                }
                if (result.inline_images != nil){
                    if(!result.inline_images!.isEmpty){
                        VStack{
                            Text("Related images").font(.title2).bold()
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack(spacing: 20){
                                    ForEach(result.inline_images!){ image in
                                        Button {
                                            guard let google = URL(string: "https://www.google.com/"),
                                                  UIApplication.shared.canOpenURL(google) else {
                                                return
                                            }
                                            UIApplication.shared.open(google,
                                                                      options: [:],
                                                                      completionHandler: nil)
                                        } label: {
                                            if let url = URL(string: image.thumbnail){
                                                AsyncImage(url: url){ phase in
                                                    if let image = phase.image {
                                                        image
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                    } else if phase.error != nil {
                                                        Color.red // Indicates an error.
                                                    } else {
                                                        Color.blue // Acts as a placeholder.
                                                    }
                                                }
                                            } else{
                                                ProgressView()
                                            }
                                        }
                                    }
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width, height: 300)
                        }
                        .padding()
                        
                    }
                }
                if (result.image_results != nil){
                    if(!result.image_results!.isEmpty){
                        VStack{
                            Text("Search results").font(.title2).bold()
                            ScrollView{
                                VStack(alignment: .leading){
                                    ForEach(result.image_results!){ image in
                                        ZStack{
                                            Rectangle().foregroundColor(.white).padding(-15).shadow(radius: 10)
                                            VStack {
                                                HStack{
                                                    VStack(alignment: .leading){
                                                        Text(image.title).font(.title).bold()
                                                            .padding(.bottom,5)
                                                        HStack{
                                                            Text(image.snippet ?? "").opacity(0.8)
                                                            Spacer()
                                                            VStack(alignment: .trailing){
                                                                ForEach(image.snippet_highlighted_words ?? [], id: \.self){ word in
                                                                    Text(word)
                                                                }.scaledToFit()
                                                                Text(image.date ?? "").bold()
                                                            }.foregroundColor(.gray)
                                                            
                                                        }
                                                        
                                                    }
                                                }
                                                Text(image.displayed_link)
                                                    .foregroundColor(.blue)
                                                    .opacity(0.6)
                                                    .font(.system(size: 16))
                                                    .padding(.top)
                                            }
                                        }
                                        .padding()
                                    }
                                    .padding(.vertical, 10)
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding()
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}

//struct ResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultViewCaller()
//    }
//}
