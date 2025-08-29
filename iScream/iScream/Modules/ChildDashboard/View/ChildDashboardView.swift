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
    @State private var navPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navPath) {
            VStack(alignment: .leading) {
                if let user = presenter.user {
                    VStack(alignment: .leading) {
                        // TODO: Needs to be in text file
                        Text("Welcome \(user.name)")
                            .font(CustomFont.headerFont)
                            .foregroundStyle(.white)
                        // TODO: This needs to be looked as it should be total points followed by increase since last X time period
                        Text("\(user.hasImproved ? "+" : "-") \(user.iceCreamPoints) Points")
                            .font(CustomFont.smallSubHeaderFont)
                            .foregroundStyle(user.hasImproved ? .red : .green )
                            .bold()

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

struct ChildDashboardChartView: View {
    @State var user: User!
    @State private var navPath = NavigationPath()

    var body: some View {
        VStack(alignment: .leading) {
            Chart {
                ForEach(user.dataPoints) {
                    LineMark(
                        x: .value("Month", $0.month),
                        y: .value("Points", $0.points)
                    )
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(user.hasImproved ? .red : .green)
                    .alignsMarkStylesWithPlotArea()

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
