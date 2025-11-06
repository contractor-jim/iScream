//
//  DashboardChildCardView.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI

struct DashboardChildCardView: View {
    @State var profile: Profile!
    @State private var interpolationValue: CGFloat = 0.0

    var body: some View {
        VStack(alignment: .leading) {
            Text(profile.userName)
                .font(CustomFont.subHeaderFont.bold())

            VStack(alignment: .leading) {
                DashBoardChildCardTitleView(profile: profile)
                    .accessibilityIdentifier("parent-dashboard-card-title-view-\(profile.userName)")
                HStack(alignment: .top, spacing: 0) {
                    DashBoardChildCardScoreView(profile: profile)
                    // TODO: This needs to be re added when we have user data
                    AnimatedChartView(profile: profile)
                }
            }
            .padding(.all, Style.fullPadding)
            .font(CustomFont.subHeaderFont)
            .background(.cellBackground)
            .cornerRadius(Style.cornerRadius)
            .accessibilityIdentifier("parent-dashboard-card-view-\(profile.userName)")
        }
    }
}

struct DashBoardChildCardTitleView: View {
    let profile: Profile!

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Text(
                String(
                    format: NSLocalizedString("dashboard.childpoints.label",
                                              bundle: .main,
                                              comment: ""),
                    profile.points)
            )
            .font(CustomFont.regularFontBody)

            Spacer()
        }
    }
}

struct DashBoardChildCardScoreView: View {
    let profile: Profile!

    var body: some View {
        VStack(alignment: .center) {
            Text("\(profile.aggregateSinceLastMonth >= 0 ? "+" : "")\(profile.aggregateSinceLastMonth)")
                .font(CustomFont.subHeaderFont)
                .lineLimit(1)
                .minimumScaleFactor(0.01)
                .foregroundStyle(profile.aggregateSinceLastMonth >= 0 ? .green : .red)
            Text(
                // TODO: HERE
                String(
                    format: NSLocalizedString("dashboard.childpoints.since.label",
                                              bundle: .main,
                                              comment: ""),
                    profile.lastMonthString)
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
