import SwiftUI

struct TracklistView: View {
    @EnvironmentObject var fileManager: FileManager

    var body: some View {
        List {
            ForEach(fileManager.audioFiles, id: \.self) { file in
                Text(file.lastPathComponent)
            }
        }
        .onAppear {
            print("audioFiles count: \(fileManager.audioFiles.count)")
        }
    }
}





struct __TracklistView_Previews: PreviewProvider {
    static var previews: some View {
        TracklistView()
            .environmentObject(FileManager())
    }
}
