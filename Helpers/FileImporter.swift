//
//  FileImporter.swift
//  Audio Shootout
//
//  Created by Remy Borsboom on 25/02/2023.
//

import SwiftUI
import AppKit
import Modules // Import the Helpers folder that contains the FileImporter file

struct UploadView: View {
    @State private var audioFiles: [URL] = []

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    let fileImporter = FileImporter()
                    fileImporter.onCompletion = { urls in
                        self.audioFiles = urls
                        if !urls.isEmpty {
                            // Transition to ContentView if at least one file was selected
                            NavigationManager.shared.transition(to: .contentView)
                        }
                    }
                    let viewController = NSHostingController(rootView: fileImporter)
                    NSApplication.shared.keyWindow?.contentViewController?.presentAsSheet(viewController)
                }) {
                    Image(systemName: "folder.fill")
                        .font(.system(size: 24))
                }
                Spacer()
                Image(systemName: "questionmark.circle.fill")
                    .font(.system(size: 24))
                Image(systemName: "key.fill")
                    .font(.system(size: 24))
            }
            .padding()

            Spacer()

            VStack {
                Image(systemName: "doc.on.clipboard.fill")
                    .font(.system(size: 72))
                Text("DROP AUDIO FILES HERE")
                    .font(.title)
                    .foregroundColor(.gray)
                    .padding(.top)

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(width: 1200, height: 800)
    }
}
