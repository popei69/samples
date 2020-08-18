//
//  ContentView.swift
//  WatchOSSample WatchKit Extension
//
//  Created by Benoit PASQUIER on 18/08/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var model: SoundEffectModel
    
    var body: some View {
        Button(action: {}, label: {
            Image("horn")
                .frame(width: 150, height: 150)
            
        })
            .buttonStyle(PlainButtonStyle())     
            .background(Color.red)
            .clipShape(Circle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: SoundEffectModel())
    }
}
