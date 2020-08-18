//
//  SoundEffectModel.swift
//  WatchOSSample WatchKit Extension
//
//  Created by Benoit PASQUIER on 18/08/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

import Combine

struct SoundEffect {
    let imageName: String
}

class SoundEffectModel: ObservableObject {
    
    @Published var effects: [SoundEffect] = [
        SoundEffect(imageName: "horn")
    ]
}
