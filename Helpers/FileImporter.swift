import SwiftUI
import AppKit

struct FileImporter: NSViewControllerRepresentable {
    var onCompletion: ([URL]) -> Void = { _ in }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeNSViewController(context: Context) -> NSViewController {
        let openPanel = NSOpenPanel()
        openPanel.allowedContentTypes = [.audio]
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
    
    func updateNSViewController(_ nsViewController: NSViewController, context: Context) {}
    
    class Coordinator: NSObject {
        let parent: FileImporter
        
        init(_ parent: FileImporter) {
            self.parent = parent
        }
    }
}
