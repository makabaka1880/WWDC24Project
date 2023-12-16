//
//  DrawBoard.swift
//  WWDC-24
//
//  Created by SeanLi on 12/16/23.
//

import SwiftUI
import UIKit
//
//struct Line {
//    var points: [CGPoint]
//    let color: UIColor
//    let lineWidth: CGFloat
//}
//
//class DrawView: UIView {
//    private var lines = [Line]()
//    var color: UIColor = .black
//    var lineWidth: CGFloat = 5
//    var drawView: DrawView?
//    func clear() {
//        print("Clear")
//        lines.removeAll()
//        setNeedsDisplay()
//        print("Clear_")
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        lines.append(Line(points: [CGPoint](), color: color, lineWidth: lineWidth))
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let point = touches.first?.location(in: self) else { return }
//        guard var lastLine = lines.popLast() else { return }
//        lastLine.points.append(point)
//        lines.append(lastLine)
//        setNeedsDisplay()
//    }
//
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//        guard let context = UIGraphicsGetCurrentContext() else { return }
//        lines.forEach { line in
//            context.setStrokeColor(line.color.cgColor)
//            context.setLineWidth(line.lineWidth)
//            context.setLineCap(.round)
//            for (i, p) in line.points.enumerated() {
//                if i == 0 {
//                    context.move(to: p)
//                } else {
//                    context.addLine(to: p)
//                }
//            }
//            context.strokePath()
//        }
//    }
//
//}
//
//
//struct DrawingPad: UIViewRepresentable {
//    @Binding var color: Color
//    @Binding var lineWidth: CGFloat
//    @Binding var drawView: DrawView?
//
//
//    
//    func makeUIView(context: Context) -> DrawView {
//        let view = DrawView()
//        view.backgroundColor = .white
//        self.drawView = view // 保存对 DrawView 的引用
//        print("Make")
//        return view
//    }
//
//
//    func updateUIView(_ uiView: DrawView, context: Context) {
//        uiView.color = UIColor(color)
//        uiView.lineWidth = lineWidth
//    }
//}
//
//struct DrawBoard: View {
//    @State private var drawingColor: Color = .black
//    @State private var lineWidth: CGFloat = 5
//    @State private var lines: [Line] = [.init(points: [], color: .black, lineWidth: 5)]
//    
//    @State private var drawView: DrawView?
//    var body: some View {
//        HStack {
//            DrawingPad(color: $drawingColor, lineWidth: $lineWidth, drawView: $drawView)
//                .edgesIgnoringSafeArea(.all)
//            VStack {
//                Button {
//                    drawingColor = .black
//                    lineWidth = 5
//                    print(lines.count)
//                } label: {
//                    Image(systemName: "pencil")
//                }
//                .font(.system(size: 75))
//                .padding()
//                Button {
//                    drawingColor = .white
//                    lineWidth = 5// 橡皮擦宽度可以更大
//                    print(lines.count)
//                } label: {
//                    Image(systemName: "eraser")
//                }
//                .font(.system(size: 75))
//                .padding()
//                Button {
//                    drawView!.clear()
//                    print(lines.count)
//                } label: {
//                    Image(systemName: "trash")
//                }
//                .font(.system(size: 75))
//                .padding()
//            }
//            .padding()
//           
//
//        }
//    }
//}

struct DrawingPad: UIViewRepresentable {
    @Binding var color: Color
    @Binding var lineWidth: CGFloat
    @Binding var drawView: DrawView?
    
    func makeUIView(context: Context) -> DrawView {
        let view = DrawView()
        view.backgroundColor = .white
        self.drawView = view // 保存对 DrawView 的引用
        return view
    }
    
    func updateUIView(_ uiView: DrawView, context: Context) {
        uiView.color = UIColor(color)
        uiView.lineWidth = lineWidth
    }
}
#Preview {
    DrawBoard()
}
