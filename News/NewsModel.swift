//
//  NewsModel.swift
//  News
//
//  Created by 박지현 on 2021/06/21.
//

import Foundation

struct News: Codable, Identifiable {
    var id = UUID() //Int, String등 hashble을 따르는 것들은 뭐든지 가능.
    var title: String?
    var urlToImage: String?
    var description: String?
    var url: String?
    var publishedAt: String?
    var author: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case urlToImage
        case description
        case url
        case publishedAt
        case author
    }
}

struct NewsList: Codable {
    var articles: [News]?
}
