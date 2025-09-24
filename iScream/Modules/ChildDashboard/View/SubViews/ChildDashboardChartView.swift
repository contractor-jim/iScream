//
//  ChildDashboardChartView.swift
//  iScream
//
//  Created by James Woodbridge on 03/09/2025.
//

import SwiftUI

struct ChildDashboardChartView: View {
    @State var user: User!
    @State private var interpolationValue: CGFloat = 0.0

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

            AnimatedChartView(user: user)
                .padding([.bottom], Style.fullPadding)
                .padding([.leading, .trailing], Style.halfPadding)
                .accessibilityIdentifier("child-dashboard-chart-view")
        }
        .frame(maxWidth: .infinity, maxHeight: 180)
        .background(.cellBackground)
        .cornerRadius(Style.cornerRadius)
    }
}
