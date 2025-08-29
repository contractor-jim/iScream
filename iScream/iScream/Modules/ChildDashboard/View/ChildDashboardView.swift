//
//  ChildDashboardView.swift
//  iScream
//
//  Created by James Woodbridge on 27/08/2025.
//

import SwiftUI
import Charts

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
            .onAppear() {
                Task {
                    await presenter.fetch()
                }
            }
        }
    }
}

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

                // TODO: Handle when no data points are present
                /*, !user.dataPoints.isEmpty*/
                ChildDashboardChartView(user: user)
            }
            .padding([.leading, .trailing, .top], 26)

            Spacer()
        }
        else {
            ProgressView()
        }
    }
}

struct ChildDashboardChartView: View {
    @State var user: User!
    @State private var navPath = NavigationPath()

    var body: some View {
        VStack(alignment: .leading) {
            Chart {
                ForEach(user.dataPoints) {
                    LineMark(
                        x: .value("", $0.month),
                        y: .value("", $0.points)
                    )
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(user.hasImproved ? .red : .green)
                    .alignsMarkStylesWithPlotArea()

                    AreaMark(
                        x: .value("", $0.month),
                        yStart: .value("", $0.points),
                        yEnd: .value("", user.max)
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
            .padding([.top], 20)
            .padding([.bottom], 16)
            .padding([.leading, .trailing], 8)
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
        .frame(maxWidth: .infinity, maxHeight: 180)
        .background(.cellBackground)
        .cornerRadius(16)
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
            .padding(.trailing, 16)
    }
}
