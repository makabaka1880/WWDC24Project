//
//  FuncApprox.swift
//  WWDC-24
//
//  Created by SeanLi on 1/11/24.
//

import SwiftUI
import UIKit
import SpriteKit


class GameScene: SKScene {
    override func didMove(to view: SKView) {
        print("You are in the game scene!")
        self.backgroundColor = .white
        updatePoints(0)
        var t = 0
        self.run(SKAction.repeatForever(SKAction.sequence([SKAction.run(){ [weak self] in
            self?.updatePoints(t % 19);
            t += 1
          },SKAction.wait(forDuration: 0.1)])))
    }
    func updatePoints(_ time: Int) {
        self.removeAllChildren()
        var list: [SKNode] = []
        var index = 0.0
        print("Updating, \(time), \(data)")
        for i in data[time] {
            var point: SKNode = SKSpriteNode(imageNamed: "Point")
            point.position = CGPoint(x: size.width / 4 + size.width / 2 / 20 * index, y: size.height / 4 + size.height / 2 / 20 * i)
            point.name = String(index)
            list.append(point)
            print(point)
            index += 1
        }
        for i in list {
            self.addChild(i)
        }
    }
}

struct FuncApprox: View {
    
    // 2. Create a variable that will initialize and host the Game Scene
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 1080, height: 800)
        return scene
    }
    
    
    var body: some View {
        // 3. Using the SpriteView, show the game scene in your SwiftUI view
        //    You can even use modifiers!
        SpriteView(scene: self.scene)
            .frame(width: 1080, height: 600)
            .ignoresSafeArea()
    }
}
#Preview {
    FuncApprox()
}

func returnList(for data: Array<any Numeric>, using function: ((any Numeric) -> (any Numeric))) -> Array<any Numeric>{
    var returned: Array<any Numeric> = []
    for i in data {
        returned.append(function(i))
    }
    return returned
}

var data = [[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20],[1.2,2,2.9,4,4.9,5.6,6.8,7.6,8.5,9.5,10.4,11.5,12.4,13.3,14.3,15.2,16.2,17,18,18.9],[0.7,2,2.8,3.4,4.6,5.2,6.3,7.2,8.2,9,9.8,10.7,11.6,12.4,13.5,14.3,15.2,16.1,17,18],[0.9,1.7,2.4,3.4,4,5,5.9,7,7.5,8.3,9,10.1,11,11.8,12.7,13.5,14.2,15.1,16,16.9],[0.9,1.7,2.3,2.8,3.8,4.6,5.5,6.6,7.1,7.8,8.5,9.4,10.5,11.1,12,12.5,13.1,14,15,16],[0.8,1.8,2.3,2.6,3.6,4.5,5.4,6.1,6.6,7.3,7.8,8.8,9.7,10.7,11.3,11.8,12.3,13.2,14.1,15],[1.1,1.5,2,2.6,3,4.2,5,5.7,6.5,6.8,7.4,8.1,8.9,10.1,10.4,10.9,11.4,12.1,13.1,14.1],[1,1.5,2,2.4,2.7,3.7,4.6,5.6,5.9,6.2,6.5,7.4,8.3,9.2,9.6,10.1,10.4,11.1,12.1,12.9],[0.8,1.6,1.8,2.1,2.7,3.5,4.2,5.2,5.3,5.5,5.9,6.9,7.6,8.4,8.9,9.1,9.5,10,10.9,11.9],[0.9,1.7,1.7,1.8,2.1,3.1,3.9,4.5,5.1,5,5.4,6.1,7.1,7.8,8.1,8.4,8.4,9,10,11],[0.9,1.3,1.4,1.3,1.9,2.5,3.6,4.3,4.4,4.6,4.6,5.4,6.4,7,7.5,7.4,7.6,8.2,9.3,10.1],[0.9,1.3,1.5,1.3,1.6,2.2,3.3,3.9,4.1,3.9,4.1,4.8,5.8,6.4,6.6,6.5,6.6,7.2,8.3,8.9],[0.8,1.3,1.1,1,1.1,2,3,3.6,3.5,3.3,3.3,4,5,5.8,5.8,5.8,5.8,6,7.1,8],[0.8,1.2,1,0.7,0.9,1.5,2.8,3.3,3,2.6,2.8,3.4,4.4,5.1,5.3,4.9,4.6,5,5.9,7],[0.8,1.1,0.8,0.5,0.4,1.4,2.4,2.8,2.6,2.2,2.2,2.5,3.9,4.5,4.4,4,3.8,4.2,4.9,6.1],[0.9,1.2,0.7,0.4,0.3,1.1,1.9,2.6,2.3,1.8,1.5,2.1,3.3,3.6,3.7,3.3,2.8,3.3,4.1,5],[0.7,1.2,0.6,-0.1,0,0.7,1.5,2,1.8,1.1,0.9,1.6,2.3,3,2.9,2.3,1.9,2.2,3.1,3.9],[0.8,0.9,0.5,-0.3,-0.4,0.4,1.3,2,1.2,0.7,0.3,0.7,1.8,2.2,1.9,1.5,0.8,1.3,2.1,3.1],[1,0.9,0.2,-0.6,-0.7,0,1,1.4,0.9,0,-0.4,0,1.2,1.6,1.3,0.5,-0.2,0.2,1.1,2],[0.9,0.9,0.2,-0.7,-1,-0.3,0.6,0.9,0.4,-0.7,-1,-0.6,0.5,1,0.7,-0.2,-0.9,-0.9,0.1,1],[0.8,0.9,0.1,-0.8,-1,-0.3,0.7,1,0.4,-0.5,-1,-0.5,0.4,1,0.7,-0.3,-1,-0.8,0.1,0.9]]

func returnListForIndex(for index: Int, size: CGSize ) -> [SKNode] {
    var list: [SKNode] = []
    var index = 0
    for i in data[index] {
        var point: SKNode = SKSpriteNode(imageNamed: "Point")
        var xCord = size.width / 2 * (1 + 1 / 20 * Double(index))
        var yCord = size.height / 2 + size.height / 2 / 20 * i
        point.position = CGPoint(x: xCord, y: yCord)
        point.name = String(index)
        list.append(point)
        print(point)
        index += 1
    }
    return list
}
