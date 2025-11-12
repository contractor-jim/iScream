//
//  BountyView.swift
//  iScream
//
//  Created by James Woodbridge on 29/08/2025.
//

import SwiftUI

struct BountyView: View, GenericView {
    @State var presenter: BountyPresenter

    init<P>(presenter: P) where P: GenericPresenter {
        guard let presenter = presenter as? BountyPresenter else {
            fatalError("Unsupported presenter type \(String(describing: type(of: presenter)))")
        }
        self.presenter = presenter
    }

    var body: some View {
        NavigationStack(path: presenter.navPath) {
            BountyStackView(presenter: presenter)
        }
    }
}

struct BountyStackView: View {
    var presenter: BountyPresenter

    var body: some View {
        VStack(alignment: .leading) {
            Text("TODO: Reimplement as child list")

            if presenter.isLoading {
                VStack(alignment: .center) {
                    Spacer()
                    ProgressView()
                        .tint(.white)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.black.opacity(0.7))
                .onAppear {
                    Task {
                        try await presenter.fetch()
                    }
                }
            } else {
                ParentListChildrenBounties(profile: presenter.profile)
            }
            // TODO: Reimplement this when we get to the children bounty view re intro
            /*
            List {
                Section {
                    ForEach(presenter.profile?.openBounties ?? []) { bounty in
                        Text(bounty.title)
                            .listRowSeparator(.hidden)
                            .accessibilityIdentifier(bounty.title)
                    }
                }
                header: {
                    Text("bounties.open.title") .textCase(nil) .font(CustomFont.subHeaderFont).bold()
                }
                .font(CustomFont.regularFontBody.weight(.regular))
                .listRowBackground(Color.cellBackground)

                Section {
                    ForEach(presenter.profile?.completedBounties ?? []) { bounty in
                        Text(bounty.title)
                            .listRowSeparator(.hidden)
                            .accessibilityIdentifier(bounty.title)
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
            */
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(.mainBackground)
        .navigationTitle("general.title.bounties")
    }
}
