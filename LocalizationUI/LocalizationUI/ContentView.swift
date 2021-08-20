//
//  ContentView.swift
//  LocalizationUI
//
//  Created by Benoit PASQUIER on 19/01/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

import SwiftUI

enum Translation {
    
    static var welcomeToMyApp: LocalizedStringKey {
        return "Welcome into my app"
    }
    
    static var startByTappingThisButton: LocalizedStringKey {
        return "Start by tapping this button"
    }
    
    static var startBrowsing: LocalizedStringKey {
        return "Start browsing"
    }
    
    static func hello(_ name: String) -> LocalizedStringKey {
        return LocalizedStringKey("HELLO_WORLD_\(name)")
    }
    
    static func hello__asString(_ name: String) -> String {
                return String.localizedStringWithFormat(NSLocalizedString("HELLO_WORLD_CROSSPLATFORM", comment: ""), name)
            }
}

struct ContentView: View {
    
    let name = "Ben"
    
    var body: some View {
        
        
        VStack(spacing: 40) {
            
            VStack(alignment: .leading) {
                Text("Welcome into my app")
                    .font(.title)
                
                Text("Start by tapping this button")
                    .font(.body)
                
                Text(Translation.hello__asString("Ben"))
                    .font(.body)
            }
            
            Button("Start browsing") { 
                // TODO - onclick
            }
            .foregroundColor(.white)
            .padding()
            .background(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)))
            .cornerRadius(10)
            
        }
        .padding()
        .border(Color(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)), width: 1)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .environment(\.locale, .init(identifier: "fr"))
    }
}
