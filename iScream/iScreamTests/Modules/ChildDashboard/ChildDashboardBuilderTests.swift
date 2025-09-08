//
//  ChildDashboardBuilderTests.swift
//  iScream
//
//  Created by James Woodbridge on 01/09/2025.
//

@testable import iScream
import Testing

struct ChildDashboardDefaultBuilderTests {

    var mockUserService: MockUserService
    let router: ChildDashboardRouter
    let interactor: ChildDashboardInteractor
    let presenter: ChildDashboardPresenterImp

    init() throws {
        mockUserService = MockUserService()
        router = ChildDashboardRouterImp()
        interactor = ChildDashboardInteractorImp(entity: ChildDashboardEntityImp(), userService: mockUserService)
        presenter = ChildDashboardPresenterImp(interactor: interactor, router: router)
    }

    @Test("POSITIVE - Can create a child dashboard module") func testFetch() throws {
        let builder = ChildDashboardDefaultBuilder()
        _ = builder.buildChildDashboardView()
        try #require(builder.container.resolve(ChildDashboardEntity.self) != nil)
        try #require(builder.container.resolve(ChildDashboardInteractor.self) != nil)
        try #require(builder.container.resolve(ChildDashboardRouter.self) != nil)
        try #require(builder.container.resolve(ChildDashboardPresenter.self) != nil)
        try #require(builder.container.resolve(ChildDashboardView.self) != nil)
        // TODO: When the opaque / boxing of the views look at this
//        try #require(testView as? RootContainerView != nil)
    }
}
