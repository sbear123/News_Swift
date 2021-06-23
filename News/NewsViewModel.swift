//
//  NewsViewModel.swift
//  News
//
//  Created by 박지현 on 2021/06/21.
//

import Foundation
import SwiftUI
import Combine

class NewsViewModel: ObservableObject {
    
    @Published var news: [News] = []
    
    var cancellationToken: AnyCancellable?
    
    init() {
        getNews()
    }
}

extension NewsViewModel {
    func getNews() {
        let country = NSLocalizedString("us", comment: "us")
        let url = URL(string: "https://newsapi.org/v2/top-headlines?apiKey=219ca3f214c941dcbea9c6291420fe4e&country="+country)
        let publisher = URLSession.shared.dataTaskPublisher(for: url!)
        
        cancellationToken = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("Finished successfuly")
                }
            },
            receiveValue: { value in
                let decoder = JSONDecoder()
                
                do {
                    let repo = try decoder.decode(NewsList.self, from: value.data)
                    DispatchQueue.main.async {
                        self.news = repo.articles ?? []
                    }
                } catch {
                    print(error)
                }
            }
        )
    }
}

struct HTTPResponse {
    let value: NewsList?
    let response: URLResponse
}
