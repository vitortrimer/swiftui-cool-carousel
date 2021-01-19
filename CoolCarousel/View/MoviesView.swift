//
//  MoviesView.swift
//  CoolCarousel
//
//  Created by Vitor Trimer on 17/01/21.
//

import SwiftUI
import KingfisherSwiftUI

struct MoviesView: View {
    
    @State private var animes = [Anime]()

    func getData() {
        guard let url = URL(string: "https://api.jikan.moe/v3/top/anime/1/upcoming") else {
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Top.self, from : data) {
                    DispatchQueue.main.async {
                        self.animes = decodedResponse.top
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknow error")")

        }.resume()
    }
    
    private func getScale(proxy: GeometryProxy) -> CGFloat {
        var scale: CGFloat = 1
        
        let x = proxy.frame(in: .global).minX
        let diff = abs(x)
        
        if diff < 100 {
            scale = 1 + (100 - diff) / 500
        }
        
        return scale
    }

    
    var body: some View {
        NavigationView {
            ScrollView {
                ScrollView(.horizontal) {
                    HStack(spacing: 50) {
                        ForEach(animes, id: \.mal_id) { anime in
                            GeometryReader { proxy in
                                NavigationLink(
                                    destination: KFImage(URL(string: anime.image_url ?? "")),
                                    label: {
                                        VStack {
                                            let scale = getScale(proxy: proxy)
                                        KFImage(URL(string: anime.image_url ?? ""))
                                                .scaledToFill()
                                                .frame(width: 150, height: 250)
                                                .clipped()
                                                .cornerRadius(5)
                                                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 2, x: 1, y: 1)
                                                .scaleEffect(CGSize(width: scale, height: scale))
                                                .animation(.easeOut(duration: 1))
                                            
                                            Text(anime.title ?? "")
                                                .padding(.top)
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(Color(.label))
                                        }
                                    }
                                )
                            }
                            .frame(width: 125, height: 300)
                        }
                    }.padding(32)
                }
                
            }
            .navigationTitle("Cool Carousel")
        }
        .onAppear(perform: getData)
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
