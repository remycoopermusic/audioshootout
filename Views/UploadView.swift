//
//  UploadView.swift
//  Audio Shootout
//
//  Created by Remy Borsboom on 25/02/2023.
//

import SwiftUI
import AppKit

class FileImporter: NSObject, UIViewControllerRepresentable {
    var onCompletion: ([URL]) -> Void = { _ in }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func updateNSViewController(_ nsViewController: NSViewController, context: Context) {}

    func makeNSViewController(context: Context) -> NSViewController {
        let openPanel = NSOpenPanel()
        openPanel.allowedFileTypes = ["public.audio"]
        openPanel.canChooseFiles = true
        openPanel.canChooseDirectories = false
        openPanel.allowsMultipleSelection = true
        openPanel.prompt = "Select"
        openPanel.begin { result in
            if result == NSApplication.ModalResponse.OK {
                self.onCompletion(openPanel.urls)
            }
        }
        return NSViewController()
    }

    class Coordinator: NSObject {
        let parent: FileImporter

        init(_ parent: FileImporter) {
            self.parent = parent
        }
    }
}


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




struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
