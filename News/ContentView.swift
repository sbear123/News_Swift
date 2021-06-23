//
//  ContentView.swift
//  News
//
//  Created by 박지현 on 2021/06/20.
//

import Foundation
import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var viewModel = NewsViewModel()
    var body: some View {
        NavigationView {
            List(viewModel.news) { item in
                NewsCell(news: item)
            }.navigationTitle("News List")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct NewsCell: View {
    @ObservedObject var viewModel = NewsViewModel()
    var news: News
    var body: some View {
        HStack {
            NavigationLink(destination: DetailView(news: news)){
                NewsImage(url: news.urlToImage ?? "")
                VStack {
                    Text(news.title!)
                        .font(.headline)
                        .lineLimit(1)
                    Text(news.description ?? "")
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                        .lineLimit(/*@START_MENU_TOKEN@*/3/*@END_MENU_TOKEN@*/)
                    HStack {
                        Text("author : \(news.author ?? "")")
                            .font(.caption)
                            .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.32, opacity: 1.0))
                            .multilineTextAlignment(.leading)
                        Text(news.publishedAt!)
                            .font(.caption)
                            .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.32, opacity: 1.0))
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
        }
    }
}

struct DetailView: View {
    let news: News
    
    var body: some View {
        VStack(alignment: .leading) {
            ImageViewURL(url: news.urlToImage ?? "", width: 200, height: 200)
            Text(news.title!)
                .font(.title2)
                .bold()
            Text(news.description ?? "")
                .font(.body)
            Text("author : \(news.author ?? "")")
                .font(.footnote)
                .fontWeight(.thin)
                .multilineTextAlignment(.trailing)
            Text("publishedAt : \(news.publishedAt!)")
                .font(.footnote)
                .fontWeight(.thin)
                .multilineTextAlignment(.trailing)
            Link("Go News", destination: URL(string: news.url!)!)
            Spacer()
        }.padding(20.0)
    }
}

struct NewsImage: View {
    let url: String
    
    var body: some View {
        ImageViewURL(url: url, width: 70, height: 70)
    }
}
