//
//  Top.swift
//  CoolCarousel
//
//  Created by Vitor Trimer on 17/01/21.
//

import Foundation

struct Top: Codable {
    let request_hash: String
    let request_cached: Bool
    let request_cache_expiry: Int
    let top: [Anime]
}
