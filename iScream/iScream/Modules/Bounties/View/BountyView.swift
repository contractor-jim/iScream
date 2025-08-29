//
//  BountyView.swift
//  iScream
//
//  Created by James Woodbridge on 29/08/2025.
//

import SwiftUI

struct BountyView: View {

    @State var presenter: BountyPresenter!
    @State private var navPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navPath) {
            VStack(alignment: .leading) {
                List {
                    Section() {
                        ForEach(presenter.user?.openBounties ?? []) { bounty in
                            Text(bounty.title)
                                .listRowSeparator(.hidden)
                        }
                    }
                    header: {
                        Text("bounties.open.title") .textCase(nil) .font(CustomFont.subHeaderFont).bold()
                    }
                    .font(CustomFont.regularFontBody.weight(.regular))
                    .listRowBackground(Color.cellBackground)
                    
                    Section() {
                        ForEach(presenter.user?.completedBounties ?? []) { bounty in
                            Text(bounty.title)
                                .listRowSeparator(.hidden)
                        }
                    }
                    header: {
                        Text("bounties.complete.title") .textCase(nil) .font(CustomFont.subHeaderFont).bold()
                    }
                    .font(CustomFont.regularFontBody.weight(.regular))
                    .listRowBackground(Color.cellBackground)
                }
                .foregroundColor(.white)
                .background(.clear)
                .scrollContentBackground(.hidden)
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(.mainBackground)
            .navigationTitle("general.title.bounties")
            .onAppear() {
                Task {
                    await presenter.fetch()
                }
            }
        }
    }
}
