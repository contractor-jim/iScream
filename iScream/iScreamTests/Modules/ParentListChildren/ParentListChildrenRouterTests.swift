//
//  ParentListChildrenRouterTests.swift
//  iScream
//
//  Created by James Woodbridge on 01/09/2025.
//

@testable import iScream
import Testing

struct ParentListChildrenRouterTests {

    let router: ParentListChildrenRouter

    init() throws {
        router = ParentListChildrenRouterImp()
    }

    @Test("POSITIVE - ParentListChildrenRouter - navigateChildDetails ") func testNavPath() {
        router.navigateChildDetailView(user: User.mockUser)
        #expect(router.nav.isEmpty == false)
        #expect(router.nav.count == 1)
    }
}
