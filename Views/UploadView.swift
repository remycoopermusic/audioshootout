//
//  UploadView.swift
//  Audio Shootout
//
//  Created by Remy Borsboom on 25/02/2023.
//

import SwiftUI

struct UploadView: View {
    @StateObject var fileManager = FileManager()

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.fileManager.chooseFiles {
                        // Completion handler called after files have been chosen
                    }
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
            } else {
                // Show selected files
                List {
                    ForEach(fileManager.audioFiles, id: \.self) { file in
                        Text(file.lastPathComponent)
                    }
                }
            }
        }
    }
}




struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
