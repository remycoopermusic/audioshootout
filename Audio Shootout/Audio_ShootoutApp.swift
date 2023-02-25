//
//  Audio_ShootoutApp.swift
//  Audio Shootout
//
//  Created by Remy Borsboom on 25/02/2023.
//

import SwiftUI

@main
struct Audio_ShootoutApp: App {
    @StateObject var fileManager = FileManager()
    @StateObject var appState = AppState()

    var body: some Scene {
        WindowGroup {
            if appState.isUploading {
                ContentView()
            } else {
                UploadView(fileManager: fileManager, isUploading: $appState.isUploading)
                    .environmentObject(appState)
                    .environmentObject(fileManager) // Add this line
                    .frame(minWidth: 600, minHeight: 400)
            }
        }
    }
}


class AppState: ObservableObject {
    @Published var audioFiles: [URL] = []
    @Published var isUploading = false
}
