import PlaygroundSupport
import SwiftUI
import UIKit

func lerp(from pointOne: Double, to pointTwo: Double, percentage: Double) -> Double {

    var percentage = percentage
    percentage = min(1, percentage)
    percentage = max(0, percentage)

    let resultPoint = pointOne + (pointTwo - pointOne) * percentage

    return resultPoint
}

struct CakeView: Animatable, View {
    let animatableData: Double

    struct InnerView: View {
        let colors: [Color] = [
            .red,
            .orange,
            .yellow,
            .green,
            .blue,
            .purple
        ]

        var body: some View {
            VStack(spacing: 0) {
                ForEach(0..<colors.count) { index in
                    Rectangle().fill(colors[index])
                    Rectangle().fill(Color.white).frame(height: 4)
                }

            }
            .frame(width: 128, height: 256)
        }
    }

    struct SliceView1: View {
        var body: some View {
            ZStack(alignment: .trailing) {
                Rectangle()
                    .fill(Color.init(red: 252/255, green: 224/255, blue: 185/255))

                Text("A VI")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
            }
            .frame(width: 128, height: 256)
        }
    }

    struct SliceView2: View {
        var body: some View {
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.init(red: 252/255, green: 224/255, blue: 185/255))

                Text("EW")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
            }
            .frame(width: 128, height: 256)
        }
    }

    var body: some View {
        VStack {
            ZStack {
                ZStack {
                    InnerView()
                        .rotation3DEffect(
                            .degrees(-90) + .degrees(lerp(from: 0, to: -30, percentage: animatableData)),
                            axis: (x: 0.0, y: 1.0, z: 0.0),
                            anchor: .leading,
                            anchorZ: 0
                        )
                        .offset(x: 64)

                    InnerView()
                        .rotation3DEffect(
                            .degrees(90) + .degrees(lerp(from: 0, to: 30, percentage: animatableData)),
                            axis: (x: 0.0, y: 1.0, z: 0.0),
                            anchor: .trailing,
                            anchorZ: 0
                        )
                        .offset(x: -64)
                }

                HStack(spacing: 0) {
                    SliceView1()
                        .rotation3DEffect(
                            .degrees(lerp(from: 0, to: -30, percentage: animatableData)),
                            axis: (0, 1, 0),
                            anchor: .trailing,
                            anchorZ: -128
                        )

                    SliceView2()
                        .rotation3DEffect(
                            .degrees(lerp(from: 0, to: 30, percentage: animatableData)),
                            axis: (0, 1, 0),
                            anchor: .leading,
                            anchorZ: -128
                        )
                }
            }
        }
    }
}

struct CakeCuttingView: View {
    @State var isSliced: Bool = false

    var body: some View {
        VStack {
            CakeView(animatableData: isSliced ? 1.0 : 0.0)
                .animation(.linear(duration: 2))

            if !isSliced {
                Button(action: slice) {
                    Text("SLICE 🔪")
                        .font(.title)
                        .fontWeight(.bold)
                }
            }
        }
        .frame(width: 768, height: 768)
        .background(Color.init(red: 128/255, green: 90/255, blue: 70/255))
    }

    func slice() {
        isSliced = true
    }
}

PlaygroundPage.current.liveView = UIHostingController(rootView: CakeCuttingView())
