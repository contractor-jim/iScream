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
                header: {
                    Text("Open Bounties") .textCase(nil) .font(CustomFont.subHeaderFont).bold()
                }
                .font(CustomFont.regularFontBody.weight(.regular))
                .listRowBackground(Color.cellBackground)

                // TODO: Add to strings file
                Section() {
                    Text("Completed Bounty 1")
                        .listRowSeparator(.hidden)
                    Text("Completed Bounty 2")
                        .listRowSeparator(.hidden)
                    Text("CompletedBounty 3")
                        .listRowSeparator(.hidden)
                }
                header: {
                    Text("Completed Bounties") .textCase(nil) .font(CustomFont.subHeaderFont).bold()
                }
                .font(CustomFont.regularFontBody.weight(.regular))
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
