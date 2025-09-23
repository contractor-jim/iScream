//
//  ChildGoodBadCell.swift
//  iScream
//
//  Created by James Woodbridge on 02/09/2025.
//

import SwiftUI
import Charts

struct ChildGoodBadCell: View {
    @State var presenter: ChildDashboardPresenter

    var body: some View {
        ZStack(alignment: .top) {
            Text("dashboard.cell.child-naughty.label")
                .font(CustomFont.smallSubHeaderFont)
                .lineLimit(2)
                .padding(.bottom, 0)
                .padding(.top, Style.fullPadding)
                .accessibilityIdentifier("child-is-naughty-cell-title")

            GoodOrBadDoughnutGraph(points: presenter.points)
        }
        .frame(maxWidth: .infinity, maxHeight: 200)
        .padding(0)
        .background(Color.cellBackground)
        .foregroundColor(Color.white)
        .cornerRadius(Style.cornerRadius)
    }
}

struct ChildGoodChartLegend: View {

    var points: [IceCreamPointSpread]

    var body: some View {
        HStack(alignment: .center) {
            ForEach(points) { point in
                HStack {
                    BasicChartSymbolShape.circle
                        .frame(width: 8, height: 8)
                        .foregroundColor(point.color)
                        .accessibilityIdentifier("child-is-naughty-chart-legend-shape-\(point.color)")
                    Text(point.title)
                        .foregroundColor(.white)
                        .font(.caption)
                        .lineLimit(1)
                        .minimumScaleFactor(0.01)
                        .accessibilityIdentifier("child-is-naughty-chart-legend-title-\(point.title)")
                }
                .padding(.top, Style.halfPadding)
            }
        }
    }
}

struct GoodOrBadDoughnutGraph: View {

    @State private var renderPoints: [Double]
    let iceCreamData: [IceCreamPointSpread]

    init(points: [IceCreamPointSpread] ) {
        iceCreamData = points
        renderPoints = Array(repeating: 0, count: iceCreamData.count)
    }

    var body: some View {
        Chart {
            ForEach(renderPoints.indices, id: \.self) { index in
                SectorMark(angle: .value("Activity", renderPoints[index]),
                           innerRadius: .ratio(0.6),
                           angularInset: 8)
                    .foregroundStyle(
                         by: .value(
                             Text(verbatim: iceCreamData[index].title),
                             iceCreamData[index].title
                         )
                     )
                    .accessibilityIdentifier("child-is-naughty-sectormark-\(iceCreamData[index].title)")
            }
        }
        .chartForegroundStyleScale(
            [String(localized: "general.good.label"): LinearGradient(gradient: Gradient(colors: [.green, .mint]),
                                                                     startPoint: .top, endPoint: .bottom),
             String(localized: "general.naughty.label"): LinearGradient(gradient: Gradient(colors: [.red, .pink]),
                                       startPoint: .top, endPoint: .bottom)]
        )
        .chartLegend(position: .bottom) {
            ChildGoodChartLegend(points: iceCreamData)
                .accessibilityIdentifier("child-is-naughty-chart-legend")
        }
        .padding(20)
        .padding(.top, 32)
        .onAppear {
            withAnimation(.easeIn(duration: Style.animationDuration).delay(Style.animationDelay)) {
                renderPoints = iceCreamData.map { Double($0.points) }
            }
        }
    }
}
