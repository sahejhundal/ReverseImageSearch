//
//  ContentView.swift
//  JsonParser
//
//  Created by DON on 11/21/22.
//

import SwiftUI

struct ResultViewCaller: View{
//    @ObservedObject var vm = ResultViewModel()
    var body: some View{
        VStack{
            ResultView(result: ResultModel(search_metadata: SearchMetadata(id: "1", status: "1"), search_information: SearchInformationModel(organic_results_state: "", query_displayed: "", total_results: 1, time_taken_displayed: 1),knowledge_graph: .elon))
        }
    }
}

struct ResultView: View {
    let result: ResultModel
    
    var body: some View {
        NavigationView{
            ScrollView {
                
                // Title
                HStack{
                    Text(result.search_information?.query_displayed ?? "resulting...").font(.system(size: 35,weight: .bold))
                }
                
                // Exact image matches
                if (result.image_sizes != nil){
                    if(!result.image_sizes!.isEmpty){
                        Link("Exact image matches", destination: URL(string: (result.image_sizes?.first!.link)!)!)
                            .font(.system(size: 16,weight: .bold))
                            .foregroundColor(.red)
                    }
                }
                
                // Knowledge Graph (if available)
                if (result.knowledge_graph != nil){
                    VStack {
                        ZStack {
                            Rectangle().foregroundColor(.black)
                            VStack{
                                if result.knowledge_graph?.image != nil{
                                    CircleImage(url: result.knowledge_graph!.image!)
                                }
                                HStack{
                                    Text(result.knowledge_graph!.title!).font(.system(size: 30,weight: .black))
                                    Image(systemName: "checkmark.seal.fill").foregroundColor(.blue)
                                }
                                Text(result.knowledge_graph!.type ?? "").font(.system(size: 16, weight: .black)).padding(.bottom, 6)
                                Text(result.knowledge_graph!.description ?? "").font(.system(size: 12, design: .monospaced))
                                
                                
                                // org and nom.
                                VStack(alignment: .leading){
                                    if result.knowledge_graph!.height != nil{
                                        Text("Height:")
                                        Text(result.knowledge_graph!.height ?? "")
                                            .padding(.leading).padding(.bottom, 3)
                                    }
                                    
                                    if result.knowledge_graph!.born != nil{
                                        Text("Born:")
                                        Text(result.knowledge_graph!.born ?? "")
                                            .padding(.leading).padding(.bottom, 3)
                                    }
                                    
                                    if result.knowledge_graph!.education != nil{
                                        Text("Education:")
                                        Text(result.knowledge_graph!.education ?? "")
                                            .padding(.leading).padding(.bottom, 3)
                                    }
                                    
                                    if result.knowledge_graph!.organizations_founded != nil{
                                        Text("Organizations founded:")
                                        Text(result.knowledge_graph!.organizations_founded ?? "")
                                            .padding(.leading).padding(.bottom, 3)
                                    }
                                    
                                    if result.knowledge_graph!.nominations != nil{
                                        Text("Nominations:")
                                        Text(result.knowledge_graph!.nominations ?? "")
                                            .padding(.leading).padding(.bottom, 3)
                                    }
                                    
                                    if result.knowledge_graph!.spouse != nil{
                                        Text("Spouse:")
                                        Text(result.knowledge_graph!.spouse ?? "")
                                            .padding(.leading).padding(.bottom, 3)
                                    }
                                    
                                    if result.knowledge_graph!.children != nil{
                                        Text("Children:")
                                        Text(result.knowledge_graph!.children ?? "")
                                            .padding(.leading).padding(.bottom, 3)
                                    }
                                }
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.system(size: 12, design: .monospaced)).padding(.top, 6)
                                .foregroundColor(.white).opacity(0.6)
                                .padding(.vertical, 6)
                                
                                // socials
                                HStack{
                                    if result.knowledge_graph?.source != nil{
                                        Link(destination: URL(string: (result.knowledge_graph?.source?.link)!)!) {
                                            Text((result.knowledge_graph?.source?.name)!).bold()
                                        }
                                    }
                                    if result.knowledge_graph?.profiles != nil{
                                        ForEach((result.knowledge_graph?.profiles)!){ profile in
                                            Link(destination: URL(string: profile.link)!) {
                                                Text(profile.name).bold()
                                            }
                                        }
                                    }
                                }
                                .foregroundColor(.blue)
                                .font(.caption)
                                
                            }
                            .foregroundColor(.white)
                            .padding()
                        }
                        .padding()
                    .shadow(color: .blue, radius: 7)
                    }
                    .padding()
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

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultViewCaller()
    }
}
