//
//  ChildDashboardBountyScore.swift
//  iScream
//
//  Created by James Woodbridge on 03/09/2025.
//

import SwiftUI

struct ChildDashboardBountyScore: View {
    var presenter: ChildDashboardPresenter

    @State var isAnimating = false

    var body: some View {
        VStack(alignment: .center) {
            // TODO: Add to strings file
            Text("general.title.bounties")
                .font(CustomFont.smallSubHeaderFont)
                .lineLimit(2)
                .padding(.bottom, 0)
                .padding(.top, Style.fullPadding)
                .accessibilityIdentifier("child-bounty-cell-title")

            Image("ice.cream.coin")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: 100)
                .foregroundStyle(
                    MeshGradient(width: 3, height: 3, points: [
                        [isAnimating ? -0.6 : 0.0, 0.0], [isAnimating ? 0.2 : 0.9, 0.0], [isAnimating ? 1.6 : 1.0, 0.0],
                                [isAnimating ? -0.6 : 0.0, 0.5], [isAnimating ? 0.1 : 0.9, isAnimating ? 0.5 : 0.8], [1.0, isAnimating ? 0.7 : 1],
                                [isAnimating ? -0.6 : -0.0, 1.0], [isAnimating ? 0.1 : 0.9, 1.0], [1.0, 1.0]
                            ], colors: [
                                .goldLight, .white, .goldLight,
                                .goldMid, .yellow, .goldMid,
                                .goldLight, .white, .goldDark
                            ])
                )
                .onAppear() {
                    withAnimation(.easeOut(duration: 5.0).repeatForever() ) { isAnimating.toggle() }
                }

            Spacer()
            
            Text(
                String(
                    format: NSLocalizedString("child.dash.bounties_complete.label",
                                              bundle: .main,
                                              comment: ""),
                    presenter.openBountyCount, presenter.totalBountyCount
                )
            )
            .font(CustomFont.extraSmallFontBody)
            .lineLimit(2)
            .padding(.bottom, Style.fullPadding)
            .padding(.top, 0)
            .accessibilityIdentifier("child-bounty-cell-completed")
        }
        .frame(maxWidth: .infinity, maxHeight: 200)
        .background(Color.cellBackground)
        .cornerRadius(Style.cornerRadius)
        .padding(0)
    }
}
