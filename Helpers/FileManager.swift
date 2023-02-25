import Foundation

class FileManager: ObservableObject {
    @Published var files: [URL] = []
    let maxFiles = 8
    
    func addFile(_ file: URL) {
        if files.count < maxFiles {
            files.append(file)
        }
    }
    
    func removeFile(at index: Int) {
        if index >= 0 && index < files.count {
            files.remove(at: index)
        }
    }
}
