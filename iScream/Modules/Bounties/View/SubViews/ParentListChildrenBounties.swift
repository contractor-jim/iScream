//
//  ParentListChildrenBounties.swift
//  iScream
//
//  Created by James Woodbridge on 12/11/2025.
//

import SwiftUI

struct ParentListChildrenBounties: View {
    @State var profile: Profile!

    var body: some View {
        List {
            ForEach(profile.children ?? []) { child in
                Section {
                    ForEach(child.bounties ?? []) { bounty in
                        BountyCardView(bounty: bounty)
                    }
                }
                header: {
                    Text(child.userName) .textCase(nil) .font(CustomFont.subHeaderFont).bold()
                }
                .font(CustomFont.regularFontBody.weight(.regular))
                .listRowBackground(Color.cellBackground)
            }
        }
        .foregroundColor(.white)
        .background(.clear)
        .scrollContentBackground(.hidden)
    }
}
