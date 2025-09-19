//
//  DashboardChildCardView.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI
import Charts

struct DashboardChildCardView: View {
    let user: User!

    var body: some View {
        VStack(alignment: .leading) {
            Text(user.name)
                .font(CustomFont.subHeaderFont.bold())

            VStack(alignment: .leading) {
                DashBoardChildCardTitleView(user: user)
                    .accessibilityIdentifier("parent-dashboard-card-title-view-\(user.name)")

                HStack(alignment: .top, spacing: 0) {
                    DashBoardChildCardScoreView(user: user)
                    DashBoardChildCardChartView(user: user)
                }
                .frame(maxHeight: 90)
            }
            .padding(.all, Style.fullPadding)
            .font(CustomFont.subHeaderFont)
            .background(.cellBackground)
            .cornerRadius(Style.cornerRadius)
            .accessibilityIdentifier("parent-dashboard-card-view-\(user.name)")
        }
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

struct DashBoardChildCardChartView: View {

    let user: User!
    // TODO: Some custom fade in animation
    var body: some View {
        Chart {
            ForEach(user.orderedDataPoints) {
                LineMark(
                    x: .value("", $0.monthString),
                    y: .value("", $0.points)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle( user.hasImproved ? .green : .red )

                AreaMark(
                    x: .value("", $0.monthString),
                    yStart: .value("", $0.points),
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
        }
        .chartLegend(.hidden)
        .chartXAxis { AxisMarks(values: .automatic) {
            AxisValueLabel()
                .foregroundStyle(Color.white)
            }
        }
        .chartYAxis { AxisMarks(values: .automatic) {
            AxisValueLabel()
                .foregroundStyle(Color.white)
            }
        }
    }
}
