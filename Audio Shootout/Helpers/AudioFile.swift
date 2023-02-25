import Foundation

struct AudioFile: Identifiable {
    var id = UUID()
    var url: URL
    var name: String {
        url.lastPathComponent
    }
}
