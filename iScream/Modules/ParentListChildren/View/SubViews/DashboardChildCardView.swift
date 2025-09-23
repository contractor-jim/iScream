//
//  DashboardChildCardView.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI

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
                    AnimatedChartView(user: user)
                }
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
