//
//  GetImage.swift
//  News
//
//  Created by 박지현 on 2021/06/21.
//

import Foundation
import Combine
import SwiftUI

struct ImageViewURL: View {
    @ObservedObject var remoteImageURL: RemoteImageURL
    
    var w: CGFloat
    var h: CGFloat
    
    init(url: String, width: CGFloat, height: CGFloat){
        remoteImageURL = RemoteImageURL(urlS: url)
        w = width
        h = height
    }
    
    var body: some View {
        Image(uiImage: (UIImage(data: remoteImageURL.data) ?? UIImage(systemName: "newspaper")!))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: w, height: h, alignment: .center)
    }
}

class RemoteImageURL: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()

    @Published var data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    
    init(urlS: String) {
        guard let url = URL(string: urlS) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            
            DispatchQueue.main.async {
                self.data = data
            }
        }.resume()
    }
}
