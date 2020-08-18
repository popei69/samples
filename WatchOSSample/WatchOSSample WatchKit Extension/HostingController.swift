//
//  HostingController.swift
//  WatchOSSample WatchKit Extension
//
//  Created by Benoit PASQUIER on 18/08/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI

class HostingController: WKHostingController<ContentView> {
    override var body: ContentView {
        ContentView(model: SoundEffectModel())
    }
}
