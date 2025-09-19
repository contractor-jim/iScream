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
                ForEach(user.orderedDataPoints) {
                    LineMark(
                        x: .value("", $0.month),
                        y: .value("", $0.points)
                    )
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(user.hasImproved ? .green : .red )
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
                                user.hasImproved ? .green.opacity(0.5) : .red.opacity(0.5),
                                user.hasImproved ? .green.opacity(0.05) : .red.opacity(0.05)
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
