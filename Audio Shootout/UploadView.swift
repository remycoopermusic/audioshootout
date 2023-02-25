//
//  UploadView.swift
//  Audio Shootout
//
//  Created by Remy Borsboom on 25/02/2023.
//

import SwiftUI

struct UploadView: View {
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    // TODO: implement action for "Open File" button
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
            
            Spacer()
            
            VStack {
                Image(systemName: "doc.on.clipboard.fill")
                    .font(.system(size: 72))
                Text("DROP AUDIO FILES HERE")
                    .font(.title)
                    .foregroundColor(.gray)
                    .padding(.top)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}


struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
