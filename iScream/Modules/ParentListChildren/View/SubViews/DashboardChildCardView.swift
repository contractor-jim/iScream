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
                // TODO: Add this again when we have added user chart data
                /*
                HStack(alignment: .top, spacing: 0) {
                    DashBoardChildCardScoreView(user: user)
                    // TODO: This needs to be re added when we have user data
                    AnimatedChartView(user: user)
                }
                */
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
