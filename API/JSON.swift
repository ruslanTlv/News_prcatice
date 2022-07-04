//
//  JSON.swift
//  API
//
//  Created by Ruslan on 27/06/22.
//

import Foundation

struct Json {
    func decodeJSON(arr: @escaping ([Articles]) -> ()) {
        let url = "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=6d252456c2774883bf85951e98f351af"
        
        guard let url = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
            }
            
            guard let data = data else {return}

            do{
                let decoder = JSONDecoder()
                let news = try decoder.decode(News.self, from: data)
                arr(news.articles)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        } .resume()
    }
}
