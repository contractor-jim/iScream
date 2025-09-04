//
//  ChildDashboardChartView.swift
//  iScream
//
//  Created by James Woodbridge on 03/09/2025.
//

import SwiftUI
import Charts

struct ChildDashboardChartView: View {
    @State var user: User!
    var presenter: ChildDashboardPresenter

    var body: some View {
        VStack(alignment: .center) {
            // TODO: Need to refactor how strings are handled a bit
            Text(
                String(
                    format: NSLocalizedString("child.dashboard.chart.title",
                                              bundle: .main,
                                              comment: ""),
                    presenter.getThisYear()
                )
            )
            .font(CustomFont.smallSubHeaderFont)
            .foregroundStyle(.white)
            .padding(0)
            .padding(.top, Style.topPadding)

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
            .padding([.bottom], Style.fullPadding)
            .padding([.leading, .trailing], Style.halfPadding)
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
        .cornerRadius(Style.cornerRadius)
    }
}
