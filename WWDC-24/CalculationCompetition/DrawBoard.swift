import SwiftUI
import Combine
import UIKit

class DrawingData: ObservableObject {
    @Published var lines: [DrawView.Line] = []

    func clearLines() {
        DispatchQueue.main.async {
            self.lines.removeAll()
        }
    }
}
class DrawView: UIView {
    var drawingData: DrawingData
    var color: UIColor = .black
    var lineWidth: CGFloat = 5
    private var cancellable: AnyCancellable?

    init(drawingData: DrawingData) {
        self.drawingData = drawingData
        super.init(frame: .zero)
        backgroundColor = .white

        // 订阅 lines 的变化
        cancellable = drawingData.$lines.sink { [weak self] _ in
            DispatchQueue.main.async {
                self?.setNeedsDisplay()
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        cancellable?.cancel()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        drawingData.lines.append(Line(points: [CGPoint](), color: color, lineWidth: lineWidth))
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
        guard var lastLine = drawingData.lines.popLast() else { return }
        lastLine.points.append(point)
        drawingData.lines.append(lastLine)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        drawingData.lines.forEach { line in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(line.lineWidth)
            context.setLineCap(.round)
            for (i, p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
    }

    struct Line {
        var points: [CGPoint]
        let color: UIColor
        let lineWidth: CGFloat
    }
}
struct DrawingPad: UIViewRepresentable {
    @ObservedObject var drawingData: DrawingData
    @Binding var color: Color
    @Binding var lineWidth: CGFloat

    func makeUIView(context: Context) -> DrawView {
        return DrawView(drawingData: drawingData)
    }

    func updateUIView(_ uiView: DrawView, context: Context) {
        uiView.color = UIColor(color)
        uiView.lineWidth = lineWidth
    }
}
struct DrawBoard: View {
    @StateObject private var drawingData = DrawingData()
    @State private var drawingColor: Color = .black
    @State private var lineWidth: CGFloat = 5

    var body: some View {
        HStack {
            VStack {
                Button {
                    drawingColor = .black
                    lineWidth = 5
                } label: {
                    Image(systemName: "pencil")
                }.padding()
                Button {
                    drawingColor = .white
                    lineWidth = 10
                } label: {
                    Image(systemName: "eraser")
                }.padding()
                Button {
                    drawingData.clearLines()
                } label: {
                    Image(systemName: "trash")
                }.padding()
                Spacer()
            }
            DrawingPad(drawingData: drawingData, color: $drawingColor, lineWidth: $lineWidth)
                .edgesIgnoringSafeArea(.all)
        }
    }
}



#Preview {
    DrawBoard().padding()
}
