//
//  QuoteService.swift
//  ClassQuote
//
//  Created by Eléna Flor on 06/01/2021.
//  Copyright © 2021 OpenClassrooms. All rights reserved.
//

import Foundation

struct TrackMessageByID: Decodable {
    fileprivate let message: TrackRootByID
}

struct TrackRootByID: Decodable {
    fileprivate let body: TrackByID
}

struct TrackByID: Decodable {
    fileprivate let track: TrackDetailByID
}

struct TrackDetailByID: Decodable {
    fileprivate let track_id: Int
    fileprivate let track_name: String
    fileprivate let track_rating: Int
    fileprivate let has_lyrics: Int
    fileprivate let album_name: String
    fileprivate let artist_name: String
}


class GetTrackDataFromApiByID {
    static func getTrackByTrackID(trackID: String) {
    
        // Create URL
        let url = URL(string: "https://api.musixmatch.com/ws/1.1/track.get?format=json&callback=callback&track_id="+trackID+"&apikey=4d14a0fcefd39fbce4c38f166e053f90")
    
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
                //print("Response data string:\n \(dataString)")
                
                let jsonData = dataString.data(using: .utf8)!
                let user = try! JSONDecoder().decode(TrackMessageByID.self, from: jsonData)
                //print(user.message.body.track)
                
                print("track_id     =", user.message.body.track.track_id)
                print("album_name   =", user.message.body.track.album_name)
                print("track_name   =", user.message.body.track.track_name)
                print("artist_name  =", user.message.body.track.artist_name)
                print("track_rating =", user.message.body.track.track_rating)
                print("has_lyrics   =", user.message.body.track.has_lyrics)
            }
        
        }
        
        task.resume()
    }
    

}




