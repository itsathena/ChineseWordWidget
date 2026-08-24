//
//  ContentView.swift
//  ChineseWord
//
//  Created by Adheena Dev on 23/08/26.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("ChineseWord Settings")
                .font(.headline)
            
            Button(action: {
                // This tells iOS to instantly dump the widget's
                // timeline cache and request a brand new one
                WidgetCenter.shared.reloadAllTimelines()
            }) {
                Text("Shuffle Widget Now")
                    .bold()
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal, 40)
        }
    }
}
