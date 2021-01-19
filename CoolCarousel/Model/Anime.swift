//
//  AnimeModel.swift
//  CoolCarousel
//
//  Created by Vitor Trimer on 17/01/21.
//

import Foundation

struct Anime: Codable {
    let mal_id: Int?
    let rank: Int?
    let title: String?
    let url: String?
    let image_url: String?
    let type: String?
    let start_date: String?
    let members: Int?
    let score: Int?
}
