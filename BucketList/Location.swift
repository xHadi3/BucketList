//
//  Location.swift
//  BucketList
//
//  Created by Hadi Al zayer on 03/10/1446 AH.
//

import Foundation
import MapKit

struct Location: Codable, Equatable, Identifiable{
    let id: UUID
    var name:String
    var description: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    #if DEBUG
    static let example = Location(id: UUID(), name: "Buckingham Palace", description: "Lit by over 40,000 lightbulbs.", latitude: 51.501, longitude: -0.141)
    #endif
    
}
