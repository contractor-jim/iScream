//
//  AnimatedChartView.swift
//  iScream
//
//  Created by James Woodbridge on 22/09/2025.
//

import SwiftUI
import Charts

struct AnimatedChartView: View {
    @State var user: User!
    @State private var interpolationValue: CGFloat = 0.0

    var body: some View {
        animatedChart(user: user)
        .onAppear {
            for i in 0..<user.orderedDataPoints.count {
                DispatchQueue.main.asyncAfter(deadline: .now() + Style.animationDelay) {
                    withAnimation(.easeInOut.delay(Double(i) * Style.animationDuration)) {
                        interpolationValue = 1.0
                    }
                }
            }
        }
    }

    private func chartLayer<V: ChartContent>(@ChartContentBuilder v: () -> V) -> some View {
        Chart {
            v()
        }
        .chartYScale(domain: user.chartYMax > user.chartYMin ? user.chartYMin...user.chartYMax : user.chartYMax...user.chartYMin )
        .chartXAxis {
            AxisMarks(values: .automatic) {
                AxisValueLabel()
                .foregroundStyle(Color.white)
            }
        }
        .chartYAxis {
            AxisMarks(values: .automatic) {
                AxisValueLabel()
                .foregroundStyle(Color.white)
            }
        }
        .chartBackground(content: { proxy in
            Color.cellBackground
                .frame(width: proxy.plotSize.width + 40, height: proxy.plotSize.height + 40 )
        })
    }

    private func animatedChart(user: User) -> some View {
        self.chartLayer(v: {
            ForEach( user.orderedDataPoints ) { pointData in
                LineMark( x: .value("", pointData.monthString), y: .value("", pointData.points) )
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle( user.hasImproved ? .green : .red )

                AreaMark(
                    x: .value("", pointData.monthString),
                    yStart: .value("", pointData.points),
                    yEnd: .value("", user.max)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            user.hasImproved ? .green.opacity(0.5) : .red.opacity(0.5),
                            user.hasImproved ? .green.opacity(0.05) : .red.opacity(0.05)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
        })
        .frame(maxHeight: 130)
        .chartOverlay(alignment: .leading, content: { proxy in
            self.chartLayer(v: {})
                .mask(
                    Rectangle()
                        .fill(Color.brown)
                        .padding(.leading, interpolationValue * proxy.plotSize.width)
                )
        })
    }
}
