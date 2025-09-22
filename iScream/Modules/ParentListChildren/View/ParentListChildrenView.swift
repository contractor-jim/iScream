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
            // TODO: Review which actor this task is created on
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
            ScrollView {
                // TODO: These should be ordered too
                if let children = presenter.user?.children {
                    ForEach(Array(children.enumerated()), id: \.offset) { _, user in
                        DashboardChildCardView(user: user)
                        .onTapGesture {
                            presenter.navigateChildDetailView(user: user)
                        }
                        .padding(.top, Style.fullPadding)
                        .padding([.trailing, .leading], Style.fullPadding)
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
        .navigationDestination(for: User.self) { user in
            Text("Child Detail view")
                .navigationTitle(user.name)
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
