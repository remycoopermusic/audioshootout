//
//  UploadView.swift
//  Audio Shootout
//
//  Created by Remy Borsboom on 25/02/2023.
//

import SwiftUI

struct UploadView: View {
    @State private var selectedFiles: [URL] = []
    @State private var fileImporter: FileImporter? = nil

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.fileImporter = FileImporter()
                    self.fileImporter?.onCompletion = { urls in
                        self.selectedFiles = urls }
                    let controller = NSHostingController(rootView: self.fileImporter!)
                    let sheet = NSWindow(
                        contentRect: controller.view.frame,
                        styleMask: [.titled, .closable],
                        backing: .buffered,
                        defer: false)
                    sheet.contentView = controller.view
                    NSApp.mainWindow?.beginSheet(sheet, completionHandler: nil)
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

            if selectedFiles.isEmpty {
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
                List(selectedFiles, id: \.self) { file in
                    Text(file.lastPathComponent)
                }
            }
        }
        .onDrop(of: ["public.file-url"], isTargeted: nil) { providers -> Bool in
            guard let item = providers.first else { return false }
            item.loadItem(forTypeIdentifier: "public.file-url", completionHandler: { (urlData, error) in
                guard error == nil, let urlData = urlData as? Data, let url = URL(dataRepresentation: urlData, relativeTo: nil) else { return }
                DispatchQueue.main.async {
                    self.selectedFiles.append(url)
                }
            })
            return true
        }
    }
}





struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
