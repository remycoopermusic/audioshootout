//
//  1_ManagerView.swift
//  Audio Shootout
//
//  Created by Remy Borsboom on 25/02/2023.
//

import SwiftUI

struct ManagerView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                Button(action: {
                    // TODO: implement action for button 1
                }) {
                    Text("Button 1")
                        .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.1)
                }
                
                Spacer()
                
                Button(action: {
                    // TODO: implement action for button 2
                }) {
                    Text("Button 2")
                        .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.1)
                }
                
                Spacer()
                
                Button(action: {
                    // TODO: implement action for button 3
                }) {
                    Text("Button 3")
                        .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.1)
                }
                
                Spacer()
                
                Button(action: {
                    // TODO: implement action for button 4
                }) {
                    Text("Button 4")
                        .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.1)
                }
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
    }
}



struct __ManagerView_Previews: PreviewProvider {
    static var previews: some View {
        ManagerView()
    }
}
