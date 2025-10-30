//
//  ChildDashboardView.swift
//  iScream
//
//  Created by James Woodbridge on 27/08/2025.
//

import SwiftUI

struct ChildDashboardView: View, GenericView {
    @State var presenter: ChildDashboardPresenter

    init<P>(presenter: P) where P: GenericPresenter {
        guard let presenter = presenter as? ChildDashboardPresenter else {
            fatalError("Unsupported presenter type \(String(describing: type(of: presenter)))")
        }
        self.presenter = presenter
    }

    var body: some View {
        NavigationStack(path: presenter.navPath) {
            VStack(alignment: .leading) {
                ChildDashboardListView(presenter: presenter)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Child Settings", systemImage: "gear") {

                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle(
                String(
                    format: NSLocalizedString("child.dashboard.title",
                                              bundle: .main,
                                              comment: ""),
                    presenter.profile?.userName ?? "")
            )
            .navigationBarTitleDisplayMode(.inline)
            .foregroundColor(.white)
            .background(.mainBackground)
            .scrollContentBackground(.hidden)
            .onAppear {
                Task {
                    try await presenter.fetch()
                }
            }
        }
    }
}

struct ChildDashboardListView: View {
    @State var presenter: ChildDashboardPresenter
    @State private var totalPoints: Int = 0

    var body: some View {
        if let profile = presenter.profile {
            VStack(alignment: .leading) {
                // TODO: This needs to be looked as it should be total points followed by increase since last X time period
                // TODO: Re-implement this when we have added user data points from Supabase
                /*
                AnimatedNumberTextView(totalPoints) { value in
                    Text(
                        String(
                            format: NSLocalizedString("child.dashboard.points",
                                                      bundle: .main,
                                                      comment: ""),
                            profile.hasImproved ? "+" : "-", value
                        )
                    )
                    .font(CustomFont.smallSubHeaderFont.bold())
                    .foregroundStyle(profile.hasImproved ? .green : .red )
                }
                */
                // Child achievements
                ChildDashboardAchievementCell(presenter: presenter)

                // Users good bad and Bounty cells
                ChildDashboardGoalCells(presenter: presenter)

                // TODO: Handle when no data points are present
                /*, !user.dataPoints.isEmpty*/
                // TODO: Re-implement this when we have pulled user data points from Supabase
                // ChildDashboardChartView(user: profile, presenter: presenter)
            }
            .padding([.leading, .trailing], Style.topPadding)
            .onAppear {
                withAnimation(.easeIn.delay(Style.animationDuration)) {
                    totalPoints = profile.points
                }
            }

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
