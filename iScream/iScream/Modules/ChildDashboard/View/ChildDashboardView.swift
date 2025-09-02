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

    ///
    struct IcecramPointSpread: Identifiable {
        let id = UUID()
        let title: String
        let points: Int
        let color: Color
    }
    // TODO: Put these in strings file
    @State private var points: [IcecramPointSpread]

    init (presenter: ChildDashboardPresenter) {
        self.presenter = presenter
        points = [
            IcecramPointSpread.init(title: "Good", points: presenter.getPositivePoints(), color: .green),
            IcecramPointSpread.init(title: "Naughty", points: presenter.getNegativePoints(), color: .red)
        ]
    }
    ///
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

                ///
                HStack {
                    ZStack(alignment: .top) {
                        // TODO: Add to the strings file
                        Text("Naughty?")
                            .font(CustomFont.smallSubHeaderFont)
                            .lineLimit(2)
                            .padding(.bottom, 0)
                            .padding(.top, 16)

                        Chart(points) { spread in
                            SectorMark(
                                angle: .value(
                                    Text(verbatim: spread.title),
                                    spread.points
                                ),
                                innerRadius: .ratio(0.6),
                                angularInset: 8
                            )

                            .foregroundStyle(
                                by: .value(
                                    Text(verbatim: spread.title),
                                    spread.title
                                )
                            )
                        }
                        .chartForegroundStyleScale(
                            ["Good": LinearGradient(gradient: Gradient(colors: [.green, .mint]), startPoint: .top, endPoint: .bottom),
                             "Naughty": LinearGradient(gradient: Gradient(colors: [.red, .pink]), startPoint: .top, endPoint: .bottom)]
                        )
                        .chartLegend(position: .bottom) {
                            HStack {
                                ForEach(points) { point in
                                    HStack {
                                        BasicChartSymbolShape.circle
                                            .foregroundColor(point.color)
                                            .frame(width: 8, height: 8)
                                        Text(point.title)
                                            .foregroundColor(.white)
                                            .font(.caption)
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.01)
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .padding(0)
                            }
                            .padding(0)
                        }
                        .padding(20)
                        .padding(.top, 32)
                        .foregroundColor(Color.white)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .background(Color.cellBackground)
                    .cornerRadius(16)
                    .padding(0)
                    .foregroundColor(Color.white)

                    Spacer()
                    // TODO: set corner radius to some global style
                    VStack(alignment: .center) {
                        Text("")
                    }
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .background(Color.cellBackground)
                    .cornerRadius(16)
                    .padding(0)
                }
                .padding(0)
                .fixedSize(horizontal: false, vertical: false)
                ///
                // TODO: Handle when no data points are present
                /*, !user.dataPoints.isEmpty*/
                ChildDashboardChartView(user: user)
            }
            .padding([.leading, .trailing,], 26)
            // .background(Color.yellow)

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
            .accessibilityIdentifier("child-dashboard-chart-view")
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
