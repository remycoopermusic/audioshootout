//
//  Audio_ShootoutApp.swift
//  Audio Shootout
//
//  Created by Remy Borsboom on 25/02/2023.
//

import SwiftUI

@main
struct Audio_ShootoutApp: App {
    var body: some Scene {
        WindowGroup {
            UploadView()
                .frame(minWidth: 600, minHeight: 400)
        }
    }
}
