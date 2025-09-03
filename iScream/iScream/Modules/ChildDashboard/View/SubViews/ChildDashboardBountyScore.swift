//
//  ChildDashboardBountyScore.swift
//  iScream
//
//  Created by James Woodbridge on 03/09/2025.
//

import SwiftUI

struct ChildDashboardBountyScore: View {
    var presenter: ChildDashboardPresenter

    var body: some View {
        VStack(alignment: .center) {
            // TODO: Add to strings file
            Text("Bounties")
                .font(CustomFont.smallSubHeaderFont)
                .lineLimit(2)
                .padding(.bottom, 0)
                .padding(.top, Style.fullPadding)
                .accessibilityIdentifier("child-bounty-cell-title")

            Image("ice.cream.coin")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: 100)
                .foregroundStyle(.yellow)

            Spacer()
            Text("20/40 Bounties completed")
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
