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
    
    @State private var viewModel = ViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        if viewModel.isUnlocked{
            NavigationStack{
                MapReader{ proxy in
                    Map(initialPosition: startPosition){
                        ForEach(viewModel.locations){ location in
                            Annotation(location.name, coordinate: location.coordinate ){
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44 , height: 44)
                                    .clipShape(.circle)
                                    .onLongPressGesture{
                                        viewModel.selectedPlace = location
                                    }
                                
                            }
                        }
                    }
                    .mapStyle(viewModel.isHybrid ? .hybrid() : .standard)
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local){
                            viewModel.addLocation(at: coordinate)
                        }
                        
                    }
                    .sheet(item: $viewModel.selectedPlace){ place in
                        EditView(location: place){
                            viewModel.update(location: $0)
                        }
                    }
                    
                }
                .toolbar(){
                    Toggle( isOn: $viewModel.isHybrid){
                        Label("switch mode", systemImage: "repeat")
                    }
            }
            
            }
        }else{
            VStack{
                Button("Unlock places", action: viewModel.authenticate)
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(.capsule)
            }
            .alert("authentication error" , isPresented: $viewModel.isAuthenticated){
                Button("ok"){
                    dismiss()
                }
                
            }message: {
                Text(viewModel.errorMassage)
            }
        }
    }
}

#Preview {
    ContentView()
}
