//
//  ContentView.swift
//  Audio Shootout
//
//  Created by Remy Borsboom on 25/02/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                // First row
                HStack {
                    // First column (33% width)
                    ManagerView()
                        .frame(maxWidth: geometry.size.width * 0.25, maxHeight: geometry.size.height * 0.5)
                    .background(Color.gray.opacity(0.1))
                                        
                    
                    // Second column (67% width)
                    WaveformView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(height: geometry.size.height * 0.5)
                
                // Second row
                TracklistView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
