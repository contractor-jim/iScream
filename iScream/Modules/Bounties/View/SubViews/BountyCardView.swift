//
//  BountyCardView.swift
//  iScream
//
//  Created by James Woodbridge on 12/11/2025.
//

import SwiftUI

struct BountyCardView: View {
    @State var bounty: Bounty!

    var body: some View {
        HStack(spacing: 0) {
            Text(bounty.title)
                .listRowSeparator(.hidden)
                .accessibilityIdentifier(bounty.title)
                .padding(.trailing, Style.halfPadding)

            if bounty.completed {
                Image(systemName: "checkmark.circle")
                    .foregroundStyle(.green)
                    .accessibilityIdentifier("bounty-complete-mark")
            } else if bounty.pendingComplete {
                Image(systemName: "exclamationmark.circle")
                    .foregroundStyle(.yellow)
                    .accessibilityIdentifier("bounty-pending-complete-mark")
            }

            Spacer()

            Text("\(bounty.points)")
                .listRowSeparator(.hidden)
                .accessibilityIdentifier(bounty.title)
                .padding(.trailing, 2)
                .foregroundStyle( GoldShapeStyle() )
                .accessibilityIdentifier("bounty-points-\(bounty.points)")

            Image(systemName: "star.fill")
                .foregroundStyle( GoldShapeStyle() )
                .padding(0)
                .padding(.bottom, 5)
                .accessibilityIdentifier("bounty-star-image")
        }
        .font(CustomFont.regularFontBody)
    }
}
