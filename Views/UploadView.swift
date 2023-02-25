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

    init(fileManager: FileManager, isUploading: Binding<Bool>) {
        self._fileManager = StateObject(wrappedValue: fileManager)
        self._isUploading = isUploading
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
                        isUploading = true
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
                    uploadFiles()
                }
                .padding()
            }

            Spacer()
        }
        .navigationTitle("")
        .background(
            NavigationLink(
                destination: ContentView(),
                isActive: $isUploading
            ) {
                EmptyView()
            }
        )
    }

    private func uploadFiles() {
        let totalBytes = fileManager.audioFiles.map({try! $0.resourceValues(forKeys: [.fileSizeKey]).fileSize!}).reduce(0, +)
        var uploadedBytes = 0

        let progressPublisher = PassthroughSubject<Double, Never>()
        let cancellable = progressPublisher
            .throttle(for: 0.5, scheduler: RunLoop.main, latest: true)
            .sink(receiveValue: { progress in
                self.progress = progress
            })

        let group = DispatchGroup()

        DispatchQueue.global(qos: .background).async {
            fileManager.audioFiles.forEach { file in
                let data = try! Data(contentsOf: file)
                // Simulating file upload
                let dataLength = Double(data.count)
                let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
                var uploaded = 0.0
                
                group.enter()
                
                for i in 1...10 {
                    RunLoop.main.run(until: Date()+0.01)
                    uploaded += dataLength/10
                    uploadedBytes += Int(uploaded)
                    let uploadProgress = Double(uploadedBytes) / Double(totalBytes)
                    progressPublisher.send(uploadProgress)
                    print("Uploaded \(i * 10)%")
                }
                
                timer.upstream.connect().cancel()
                group.leave()
            }
            
            group.notify(queue: .main) {
                cancellable.cancel()
                DispatchQueue.main.async {
                    isUploading = true
                    print("isUploading set to true")
                }
            }
        }
    }


}




struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView(fileManager: FileManager(), isUploading: .constant(false))
    }
}
