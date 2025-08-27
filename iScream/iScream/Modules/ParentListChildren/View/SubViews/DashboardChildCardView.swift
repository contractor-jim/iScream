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

            DashBoardChildCardTitleView(user: user)
                .accessibilityIdentifier("parent-dashboard-card-title-view-\(user.name)")
            
            HStack(alignment: .top, spacing: 0) {
                DashBoardChildCardScoreView(user: user)
                DashBoardChildCardChartView(user: user)
            }
            .frame(maxHeight: 90)
        }
        .padding(.all, 16)
        .font(.custom(CustomFont.regularFontName, size: 18))
        .background(.cellBackground)
        .cornerRadius(16)
        .accessibilityIdentifier("parent-dashboard-card-view-\(user.name)")
    }
}

struct DashBoardChildCardTitleView: View {
    let user: User!

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Text(user.name)
                .font(.custom(CustomFont.regularFontName, size: 18))
                .fontWeight(.bold)

            Spacer()
            Text(
                String(format: NSLocalizedString("dashboard.childpoints.label", bundle: .main, comment: ""), user.iceCreamPoints)
            )
                .font(.custom(CustomFont.regularFontName, size: 18))
                .fontWeight(.bold)
        }
    }
}

struct DashBoardChildCardScoreView: View {
    let user: User!

    var body: some View {
        VStack(alignment: .center) {
            Text("\(user.aggregateSinceLastMonth >= 0 ? "+" : "")\(user.aggregateSinceLastMonth)")
                .font(.custom(CustomFont.headerFontName, size: 24))
                .lineLimit(1)
                .minimumScaleFactor(0.01)
                .foregroundStyle(user.aggregateSinceLastMonth >= 0 ? .green : .red)
            Text(
                String(format: NSLocalizedString("dashboard.childpoints.since.label", bundle: .main, comment: ""), user.dataPoints.dropLast().last!.month))
                .font(.custom(CustomFont.regularFontName, size: 10))
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(2)
        }
        .frame(maxWidth: 65)
        .padding([.trailing], 8)
    }
}

struct DashBoardChildCardChartView: View {

    let user: User!
    // TODO: Some custom fade in animation
    var body: some View {
        Chart {
            ForEach(user.dataPoints) {
                LineMark(
                    x: .value("Month", $0.month),
                    y: .value("Points", $0.points)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle( user.hasImproved ? .red : .green)

                AreaMark(
                    x: .value("Month", $0.month),
                    yStart: .value("Points", $0.points),
                    yEnd: .value("amountEnd", user.max)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            user.hasImproved ? .red.opacity(0.5) : .green.opacity(0.5),
                            user.hasImproved ? .red.opacity(0.05) : .green.opacity(0.05)
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
