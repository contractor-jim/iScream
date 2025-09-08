//
//  ChildDashboardView.swift
//  iScream
//
//  Created by James Woodbridge on 27/08/2025.
//

import SwiftUI

struct ChildDashboardView: View {
    @State var presenter: ChildDashboardPresenter!

    var body: some View {
        NavigationStack(path: presenter.navPath) {
            VStack(alignment: .leading) {
                ChildDashboardListView(presenter: presenter)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    ToolBarSettings()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .foregroundColor(.white)
            .background(.mainBackground)
            .scrollContentBackground(.hidden)
            .onAppear {
                Task {
                    await presenter.fetch()
                }
            }
        }
    }
}
// TODO: break this out into its own file
struct ChildDashboardListView: View {
    var presenter: ChildDashboardPresenter

    var body: some View {
        if let user = presenter.user {
            VStack(alignment: .leading) {
                Text(
                    String(
                        format: NSLocalizedString("child.dashboard.title",
                                                  bundle: .main,
                                                  comment: ""),
                        user.name)
                )
                .font(CustomFont.headerFont)
                .foregroundStyle(.white)
                .padding(.top, Style.topPadding)
                // TODO: This needs to be looked as it should be total points followed by increase since last X time period
                Text(
                    String(
                        format: NSLocalizedString("child.dashboard.points",
                                                  bundle: .main,
                                                  comment: ""),
                        user.hasImproved ? "+" : "-", user.iceCreamPoints
                    )
                )
                .font(CustomFont.smallSubHeaderFont.bold())
                .foregroundStyle(user.hasImproved ? .red : .green )

                // Child achievements
                ChildDashboardAchievementCell(presenter: presenter)

                // Users good bad and Bounty cells
                ChildDashboardGoalCells(presenter: presenter)

                // TODO: Handle when no data points are present
                /*, !user.dataPoints.isEmpty*/
                ChildDashboardChartView(user: user, presenter: presenter)
            }
            .padding([.leading, .trailing], Style.topPadding)

            Spacer()
        } else {
            ProgressView()
        }
    }
}

struct ChildDashboardGoalCells: View {
    var presenter: ChildDashboardPresenter

    var body: some View {
        HStack {
            ChildGoodBadCell(presenter: presenter)
            Spacer()
            ChildDashboardBountyScore(presenter: presenter)
        }
        .fixedSize(horizontal: false, vertical: false)
    }
}

struct ToolBarSettings: View {
    var body: some View {
        Image(systemName: "gear")
            .resizable()
            .frame(width: 22, height: 22)
            .background {
                Circle()
                    .foregroundStyle(Color.white.opacity(0.2))
                    .frame(width: 28, height: 28)
            }
            .padding(.trailing, Style.fullPadding)
    }
}
