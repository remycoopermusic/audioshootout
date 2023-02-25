import Foundation
import Combine
import SwiftUI

class FileUploader {
    static func uploadFiles(fileManager: FileManager, isUploading: Binding<Bool>, completion: ((Double) -> Void)? = nil) {
        let totalBytes = fileManager.audioFiles.map({try! $0.resourceValues(forKeys: [.fileSizeKey]).fileSize!}).reduce(0, +)
        var uploadedBytes = 0

        let progressPublisher = PassthroughSubject<Double, Never>()
        let cancellable = progressPublisher
            .throttle(for: 0.5, scheduler: RunLoop.main, latest: true)
            .sink(receiveValue: { progress in
                completion?(progress)
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
                    isUploading.wrappedValue = true
                    completion?(1.0)
                    print("isUploading set to true")
                }
            }
        }
    }
}
