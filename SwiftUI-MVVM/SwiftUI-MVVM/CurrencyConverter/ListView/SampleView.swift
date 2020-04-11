//
//  SampleView.swift
//  SwiftUI-MVVM
//
//  Created by Benoit PASQUIER on 19/01/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

import SwiftUI

struct SampleView: View {
    
    @State var login: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
            Text("Welcome to my awesome app")
                .font(.headline)
            
            Text("Start by logging in")
                .font(.subheadline)
            
            
            
            VStack {
                TextField("", text: $login)
                    .font(.body)
                TextField("", text: $password)
            }
            .padding()
            
        }
    }
}

struct SampleView_Previews: PreviewProvider {
    static var previews: some View {
        SampleView()
    }
}
