//
//  ContentView.swift
//  BucketList
//
//  Created by Hadi Al zayer on 28/09/1446 AH.
//

import MapKit
import SwiftUI

struct ContentView: View {
    
    let startPosition = MapCameraPosition.region(
    MKCoordinateRegion(
        // the location where the map starts for example this is almost saudi Arabia
        center: CLLocationCoordinate2D(latitude: 23, longitude: 45),
        // how much to show around it
        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
    )
    )
    
    @State private var locations = [Location]()
    @State private var selectedPlace:Location?
    
    var body: some View {
        MapReader{ proxy in
            Map(initialPosition: startPosition){
                ForEach(locations){ location in
                    Annotation(location.name, coordinate: location.coordinate ){
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundStyle(.red)
                            .frame(width: 44 , height: 44)
                            .clipShape(.circle)
                            .onLongPressGesture{
                                selectedPlace = location
                            }
                    }
                }
            }
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local){
                        let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
                        locations.append(newLocation)
                    }
                    
                }
                .sheet(item: $selectedPlace){ place in
                    EditView(location: place){ newLocation in
                        if let index = locations.firstIndex(of: place){
                            locations[index] = newLocation
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
