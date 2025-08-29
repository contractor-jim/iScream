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
        VStack {
            List {
                // TODO: Add to strings file
                Section() {
                    Text("Bounty 1")
                        .listRowSeparator(.hidden)
                    Text("Bounty 2")
                        .listRowSeparator(.hidden)
                    Text("Bounty 3")
                        .listRowSeparator(.hidden)
                }
                header: { Text("Open Bounties") .textCase(nil) .font(.title) }
                .listRowBackground(Color.cellBackground)

                // TODO: Add to strings file
                Section("Completed Bounties") {
                    Text("Completed Bounty 1")
                        .listRowSeparator(.hidden)
                    Text("Completed Bounty 2")
                        .listRowSeparator(.hidden)
                    Text("CompletedBounty 3")
                        .listRowSeparator(.hidden)
                }
                .listRowBackground(Color.cellBackground)
            }
            .foregroundColor(.white)
            .background(.clear)
            .scrollContentBackground(.hidden)
        }
        .background(.mainBackground)
        //.navigationTitle("Bounties")
    }
}
