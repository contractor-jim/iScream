//
//  BountyView.swift
//  iScream
//
//  Created by james Woodbridge on 29/08/2025.
//

import SwiftUI

struct BountyView: View {

    @State var presenter: BountyPresenter!
    var body: some View {
        List {
            // TODO: Add to strings file
            Section("Open Bounties") {
                Text("Bounty 1")
                Text("Bounty 2")
                Text("Bounty 3")
            }

            // TODO: Add to strings file
            Section("Completed Bounties") {
                Text("Completed Bounty 1")
                Text("Completed Bounty 2")
                Text("CompletedBounty 3")
            }
        }
    }
}
