//
//  UploadView.swift
//  Audio Shootout
//
//  Created by Remy Borsboom on 25/02/2023.
//

import SwiftUI
import Combine

struct UploadView: View {
    @StateObject var fileManager: FileManager
    @Binding var isUploading: Bool
    @State private var progress: Double = 0.0

    var completion: (([URL]) -> Void)?

    init(fileManager: FileManager, isUploading: Binding<Bool>, completion: (([URL]) -> Void)? = nil) {
        self._fileManager = StateObject(wrappedValue: fileManager)
        self._isUploading = isUploading
        self.completion = completion
    }

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "folder.fill")
                    .font(.system(size: 24))
                Spacer()
                Image(systemName: "questionmark.circle.fill")
                    .font(.system(size: 24))
                Image(systemName: "key.fill")
                    .font(.system(size: 24))
            }
            .padding()

            Spacer()

            if fileManager.audioFiles.isEmpty {
                VStack {
                    Image(systemName: "doc.on.clipboard.fill")
                        .font(.system(size: 72))
                    Text("DROP AUDIO FILES HERE")
                        .font(.title)
                        .foregroundColor(.gray)
                        .padding(.top)

                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onTapGesture {
                    fileManager.chooseFiles {
                        isUploading = false
                    }
                }
                .onDrop(of: ["public.file-url"], isTargeted: nil) { providers -> Bool in
                    guard let item = providers.first else { return false }
                    item.loadItem(forTypeIdentifier: "public.file-url", completionHandler: { (urlData, error) in
                        guard error == nil, let urlData = urlData as? Data, let url = URL(dataRepresentation: urlData, relativeTo: nil) else { return }
                        DispatchQueue.main.async {
                            fileManager.audioFiles.append(url)
                        }
                    })
                    return true
                }
            } else {
                // Show selected files
                List {
                    ForEach(fileManager.audioFiles, id: \.self) { file in
                        Text(file.lastPathComponent)
                     }
                }
                Button("Continue") {
                    FileUploader.uploadFiles(fileManager: fileManager, isUploading: $isUploading) {_ in
                        // Optional completion code
                    }
                    
                    NavigationLink(destination: ContentView(), isActive: $isUploading) {
                        EmptyView()
                    }
                }
                .padding()
            }

            Spacer()
        }
            
    }
    
}



struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView(fileManager: FileManager(), isUploading: .constant(false))
    }
}
