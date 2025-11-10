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
            ZStack {
                if (profile.dataPoints ?? []).count == 0 {
                    Text(.parentDashboardChildCardNoPoints)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.all, Style.fullPadding)
                        .multilineTextAlignment(.center)
                        .font(CustomFont.regularFontBody)
                        .accessibilityIdentifier("parent-dashboard-card-no-points-label")
                } else {
                    VStack(alignment: .leading) {
                        DashBoardChildCardTitleView(profile: profile)
                            .accessibilityIdentifier("parent-dashboard-card-title-view-\(profile.userName)")

                        HStack(alignment: .top, spacing: 0) {
                            DashBoardChildCardScoreView(profile: profile)

                            AnimatedChartView(profile: profile)
                        }
                    }
                }
            }
        }
        .padding(.all, Style.fullPadding)
        .font(CustomFont.subHeaderFont)
        .background(.cellBackground)
        .cornerRadius(Style.cornerRadius)
        .accessibilityIdentifier("parent-dashboard-card-view-\(profile.userName)")
    }
}

struct DashBoardChildCardTitleView: View {
    let profile: Profile!

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Text(profile.userName)
                .font(CustomFont.subHeaderFont.bold())
                .padding(0)
                .padding([.leading], Style.halfPadding)
                .accessibilityIdentifier("parent-dashboard-card-title-user-name-\(profile.userName)")

            Spacer()

            Text(
                String(
                    format: NSLocalizedString("dashboard.childpoints.label",
                                              bundle: .main,
                                              comment: ""),
                    profile.points)
            )
            .font(CustomFont.regularFontBody)
            .padding([.trailing], Style.halfPadding)
            .accessibilityIdentifier("parent-dashboard-card-title-points-\(profile.points)")
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
                .accessibilityIdentifier("parent-dashboard-card-profile-points-\(profile.aggregateSinceLastMonth >= 0 ? "+" : "")\(profile.aggregateSinceLastMonth)")

            Text(
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
            .accessibilityIdentifier("parent-dashboard-card-since-label-\(profile.lastMonthString)")
        }
        .frame(maxWidth: 65)
        .padding([.trailing], Style.halfPadding)
    }
}
