//
//  ChildGoodBadCell.swift
//  iScream
//
//  Created by James Woodbridge on 02/09/2025.
//

import SwiftUI
import Charts

struct ChildGoodBadCell: View {
    var presenter: ChildDashboardPresenter

    var body: some View {
        ZStack(alignment: .top) {
            Text("dashboard.cell.child-naughty.label")
                .font(CustomFont.smallSubHeaderFont)
                .lineLimit(2)
                .padding(.bottom, 0)
                .padding(.top, 16)

            Chart(presenter.points) { spread in
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
                [String(localized: "general.good.label"): LinearGradient(gradient: Gradient(colors: [.green, .mint]),
                                                                         startPoint: .top, endPoint: .bottom),
                 String(localized: "general.naughty.label"): LinearGradient(gradient: Gradient(colors: [.red, .pink]),
                                           startPoint: .top, endPoint: .bottom)]
            )
            .chartLegend(position: .bottom) {
                ChildGoodChartLegend(points: presenter.points)
            }
            .padding(20)
            .padding(.top, 32)
            .foregroundColor(Color.white)
        }
        .frame(maxWidth: .infinity, maxHeight: 200)
        .padding(0)
        .background(Color.cellBackground)
        .foregroundColor(Color.white)
        .cornerRadius(Style.cornerRadius)
    }
}


struct ChildGoodChartLegend: View {

    var points: [IcecramPointSpread]

    var body: some View {
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
                .padding(.top, 8)
            }
            .frame(maxWidth: .infinity)
            .padding(0)
        }
        .padding(0)
    }
}
