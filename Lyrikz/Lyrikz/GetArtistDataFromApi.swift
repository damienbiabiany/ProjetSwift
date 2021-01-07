//
//  QuoteService.swift
//  ClassQuote
//
//  Created by Eléna Flor on 06/01/2021.
//  Copyright © 2021 OpenClassrooms. All rights reserved.
//

import Foundation


struct Message: Decodable {
    fileprivate let message:Root
}

struct Root: Decodable {
    fileprivate let body: ArtistList
}

struct ArtistList: Decodable {
    fileprivate let artist_list : [Artist]
}

struct Artist: Decodable {
    fileprivate let artist: ArtistDetail
}

struct ArtistDetail: Decodable {
    fileprivate let artist_id: Int
    fileprivate let artist_name: String
    fileprivate let artist_country :String
    fileprivate let artist_rating : Int
}


class GetArtistDataFromApi {
 
    static func getArtist(artistName: String) {
        
        // Create URL
        let url = URL(string: "https://api.musixmatch.com/ws/1.1/artist.search?format=json&callback=callback&q_artist="+artistName+"&apikey=4d14a0fcefd39fbce4c38f166e053f90")
        guard let requestUrl = url else { fatalError() }

        // Create URL Request
        var request = URLRequest(url: requestUrl)

        // Specify HTTP Method to use
        request.httpMethod = "GET"

        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            
            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
                
            
                let jsonData = dataString.data(using: .utf8)!
                let user = try! JSONDecoder().decode(Message.self, from: jsonData)
                // print(user.message.body.artist_list)
                
                for value in user.message.body.artist_list {
                    print("artist id        =",value.artist.artist_id)
                    print("artist country   =",value.artist.artist_country)
                    print("artist name      =",value.artist.artist_name)
                    print("artist rating    =",value.artist.artist_rating)
                    print("")
                    
                }
                   
            }
        
        }
        
        task.resume()
    }

}


