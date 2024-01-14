//
//  ContentView.swift
//  WWDC-24
//
//  Created by SeanLi on 12/16/23.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 1080, height: 800)
        return scene
    }
    var body: some View {
        VStack {
//            CalculationCompetitionView()
            SpriteView(scene: self.scene)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
