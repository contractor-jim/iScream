//
//  ParentListChildrenView.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI

struct ParentListChildrenView: View {

    @State var presenter: ParentListChildrenPresenter!

    var body: some View {
        NavigationStack(path: presenter.navPath) {
            DashboardChildCellView(presenter: presenter)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    ToolBarPlus()
                }
            }
            .navigationDestination(for: User.self) { user in
                // TODO: Replace this with the child dashboard
                Text("Child Detail view")
                    .navigationTitle(user.name)
                    .navigationBarTitleDisplayMode(.inline)
            }
            .navigationTitle("general.title.people")
            .scrollContentBackground(.hidden)
            .background(.mainBackground)
            .foregroundColor(.white)
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
    var presenter: ParentListChildrenPresenter

    var body: some View {
        ZStack {
            ScrollView {
                if let children = presenter.user?.children {
                    ForEach(Array(children.enumerated()), id: \.offset) { _, user in
                        // TODO: Some custom press animation
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
    }
}

struct ToolBarPlus: View {
    var body: some View {
        Image(systemName: "plus")
            .resizable()
            .frame(width: 14, height: 14)
            .background {
                Circle()
                    .foregroundStyle(Color.white.opacity(0.2))
                    .frame(width: 28, height: 28)
            }
            .padding(.trailing, Style.fullPadding)
    }
}
