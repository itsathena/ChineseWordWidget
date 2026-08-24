//
//  ChineseWordWidgetBundle.swift
//  ChineseWordWidget
//
//  Created by Adheena Dev on 23/08/26.
//

import WidgetKit
import SwiftUI

@main
struct ChineseWordWidgetBundle: WidgetBundle {
    var body: some Widget {
        ChineseWordWidget()
        ChineseWordWidgetControl()
        ChineseWordWidgetLiveActivity()
    }
}
