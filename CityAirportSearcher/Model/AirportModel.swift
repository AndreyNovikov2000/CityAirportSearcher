//
//  AirportModel.swift
//  CityAirportSearcher
//
//  Created by Andrey Novikov on 1/2/21.
//

import Foundation

// MARK: - Welcome

struct WelcomeElement: Codable, Hashable {
    let userID, id: Int
    let title, body: String
    
    init(city: String, coordinates: String) {
        title = city
        body = coordinates
        userID = 0
        id = 0
    }

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

typealias AirportModel = [WelcomeElement]


struct Response: Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let author: String?
    let title, articleDescription: String
    let url: String
    let urlToImage: String?
    let publishedAt: Date
    let content: String

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}


extension AirportModel: Equatable {
    static func ==(lhs: AirportModel, rhs: AirportModel) -> Bool {
//        lhs.status == rhs.status
        return true
    }
}

extension AirportModel: Hashable {
    func hash(into hasher: inout Hasher) {
//        hasher.combine(status
    }
}
