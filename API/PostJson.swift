//
//  PostJson.swift
//  API
//
//  Created by Ruslan on 27/06/22.
//

import Foundation

struct JSON {
    func JSON(arr: @escaping ([Characters]) -> ()) {
        
        let url = "https://api.opendota.com/api/heroStats"
        
        guard let url = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
            }
            
            guard let data = data else {return}

            do {
                let decoder = JSONDecoder()
                let characters = try decoder.decode([Characters].self, from: data)
                arr(characters)
            } catch {
                print(error.localizedDescription)
            }
        } .resume()
    }
}
