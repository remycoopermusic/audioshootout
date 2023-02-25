import SwiftUI
import Combine

class FileManager: NSObject, ObservableObject {
    @Published var audioFiles: [URL] = []
    var maxFiles = 8
    
    func chooseFiles(completion: @escaping () -> Void) {
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = true
        openPanel.canChooseDirectories = false
        openPanel.allowedContentTypes = [.audio]
        
        openPanel.begin { response in
            if response == .OK {
                let urls = openPanel.urls.prefix(self.maxFiles - self.audioFiles.count)
                self.audioFiles.append(contentsOf: urls)
                self.printFilesLocation()
            }
            completion()
        }
    }
    
    func removeFile(at index: IndexSet) {
        audioFiles.remove(atOffsets: index)
    }
    
    func printFilesLocation() {
        for file in audioFiles {
            let bookmarkData = try! file.bookmarkData()
            var isStale = false
            let url = try! URL(resolvingBookmarkData: bookmarkData, bookmarkDataIsStale: &isStale)
            print("File location: \(url)")
        }
    }
}
