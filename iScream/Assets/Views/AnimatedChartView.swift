//
//  AnimatedChartView.swift
//  iScream
//
//  Created by James Woodbridge on 22/09/2025.
//

import SwiftUI
import Charts

struct AnimatedChartView: View {
    @State var profile: Profile!
    @State private var interpolationValue: CGFloat = 0.0

    var body: some View {
        animatedChart(profile: profile)
        .onAppear {
            for i in 0..<profile.orderedDataPoints.count {
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
        .chartYScale(domain: profile.chartYMax > profile.chartYMin ? profile.chartYMin...profile.chartYMax : profile.chartYMax...profile.chartYMin )
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

    private func animatedChart(profile: Profile) -> some View {
        self.chartLayer(v: {
            ForEach( profile.orderedDataPoints ) { pointData in
                LineMark( x: .value("", pointData.monthString), y: .value("", pointData.points) )
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle( profile.hasImproved ? .green : .red )

                AreaMark(
                    x: .value("", pointData.monthString),
                    yStart: .value("", pointData.points),
                    yEnd: .value("", profile.max)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            profile.hasImproved ? .green.opacity(0.5) : .red.opacity(0.5),
                            profile.hasImproved ? .green.opacity(0.05) : .red.opacity(0.05)
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
