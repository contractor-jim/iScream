//
//  ParentListChildrenView.swift
//  iScream
//
//  Created by James Woodbridge on 26/08/2025.
//

import SwiftUI

struct ParentListChildrenView: View {

    @State var presenter: ParentListChildrenPresenter!
    @State private var navPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navPath) {
            DashboardChildCellView(users: presenter.user?.children ?? [], navPath: $navPath)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    ToolBarPlus()
                }
            }
            .navigationDestination(for: User.self) { user in
                Text("Test")
                    .navigationTitle(user.name)
                    .navigationBarTitleDisplayMode(.inline)
            }
            .navigationTitle("general.title.people")
            .scrollContentBackground(.hidden)
            .background(.mainBackground)
            .foregroundColor(.white)
        }
        .onAppear() {
            // TODO: Review which actor this task is created on
            Task {
                await presenter.fetch()
            }
        }
    }
}

struct DashboardChildCellView: View {
    let users: [User]
    @Binding var navPath: NavigationPath

    var body: some View {
        ZStack {
            ScrollView {
                ForEach (Array(users.enumerated()), id: \.offset) { index, user in
                    // TODO: Some custom press animation
                    DashboardChildCardView(user: user)
                        .onTapGesture {
                            navPath.append(users[index])
                        }
                        .padding(.top, 16)
                        .padding([.trailing, .leading], 16)
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
            .padding(.trailing, 16)
    }
}
