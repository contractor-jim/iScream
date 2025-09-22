//
//  DashboardChildCardView.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI
import Charts

struct DashboardChildCardView: View {
    @State var user: User!
    @State private var interpolationValue: CGFloat = 0.0

    var body: some View {
        VStack(alignment: .leading) {
            Text(user.name)
                .font(CustomFont.subHeaderFont.bold())

            VStack(alignment: .leading) {
                DashBoardChildCardTitleView(user: user)
                    .accessibilityIdentifier("parent-dashboard-card-title-view-\(user.name)")

                HStack(alignment: .top, spacing: 0) {
                    DashBoardChildCardScoreView(user: user)
                    animatedChart(user: user)
                }
                .onAppear {
                    for i in 0..<user.orderedDataPoints.count {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            withAnimation(.easeInOut.delay(Double(i) * 0.05)) {
                                interpolationValue = 1.0
                            }
                        }
                    }
                }
            }
            .padding(.all, Style.fullPadding)
            .font(CustomFont.subHeaderFont)
            .background(.cellBackground)
            .cornerRadius(Style.cornerRadius)
            .accessibilityIdentifier("parent-dashboard-card-view-\(user.name)")
        }
    }

    private func chart<V: ChartContent>(@ChartContentBuilder v: () -> V) -> some View {
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
        self.chart(v: {
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
            self.chart(v: {})
            .mask(
                Rectangle()
                    .fill(Color.brown)
                    .padding(.leading, interpolationValue * proxy.plotSize.width)
            )
        })
    }
}

struct DashBoardChildCardTitleView: View {
    let user: User!

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Text(
                String(
                    format: NSLocalizedString("dashboard.childpoints.label",
                                              bundle: .main,
                                              comment: ""),
                    user.iceCreamPoints)
            )
            .font(CustomFont.regularFontBody)

            Spacer()
        }
    }
}

struct DashBoardChildCardScoreView: View {
    let user: User!

    var body: some View {
        VStack(alignment: .center) {
            Text("\(user.aggregateSinceLastMonth >= 0 ? "+" : "")\(user.aggregateSinceLastMonth)")
                .font(CustomFont.subHeaderFont)
                .lineLimit(1)
                .minimumScaleFactor(0.01)
                .foregroundStyle(user.aggregateSinceLastMonth >= 0 ? .green : .red)
            Text(
                String(
                    format: NSLocalizedString("dashboard.childpoints.since.label",
                                              bundle: .main,
                                              comment: ""),
                    user.dataPoints.dropLast().last!.monthString)
            )
            .font(CustomFont.smallFontBody)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            .lineLimit(2)
        }
        .frame(maxWidth: 65)
        .padding([.trailing], Style.halfPadding)
    }
}
