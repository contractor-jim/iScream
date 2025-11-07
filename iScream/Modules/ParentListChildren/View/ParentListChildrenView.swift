//
//  ParentListChildrenView.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI
import Charts

struct ParentListChildrenView: View, GenericView {

    @State var presenter: ParentListChildrenPresenter

    init<P>(presenter: P) where P: GenericPresenter {
        guard let presenter = presenter as? ParentListChildrenPresenter else {
            fatalError("Unsupported presenter type \(String(describing: type(of: presenter)))")
        }
        self.presenter = presenter
    }

    var body: some View {
        NavigationStack(path: presenter.navPath) {
            DashboardChildCellView(presenter: presenter)
        }
        .onAppear {
            Task {
                await presenter.fetch()
            }
        }
    }
}

struct DashboardChildCellView: View {
    @State var presenter: ParentListChildrenPresenter

    var body: some View {
        ZStack {
            if (presenter.userProfile?.children ?? []).count == 0 {
                Text( .parentDashboardNoChildrenLabel)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding([.trailing, .leading], Style.fullPadding)
                    .multilineTextAlignment(.center)
                    .font(CustomFont.regularFontBody)
                    .accessibilityIdentifier("parent-dashboard-no-children-label")
            } else {
                ScrollView {
                    // TODO: These should be ordered too
                    if let children = presenter.userProfile?.children {
                        ForEach(Array(children.enumerated()), id: \.offset) { _, childProfile in
                            DashboardChildCardView(profile: childProfile)
                                .onTapGesture {
                                    // TODO: Re implement this
                                    // presenter.navigateChildDetailView(user: user)
                                }
                                .padding(.top, Style.fullPadding)
                                .padding([.trailing, .leading], Style.fullPadding)
                        }
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("AddPerson", systemImage: "plus") {

                }
            }
        }
        .navigationDestination(for: Profile.self) { profile in
            Text("Child Detail view")
                .navigationTitle(profile.userName)
                .navigationBarTitleDisplayMode(.inline)
        }
        .navigationTitle(Text("general.title.people"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationSubtitle("Synced just now")
        .scrollContentBackground(.hidden)
        .background(.mainBackground)
        .foregroundColor(.white)
    }
}
