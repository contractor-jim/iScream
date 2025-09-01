//
//  ParentListChildrenBuilderTests.swift
//  iScream
//
//  Created by James Woodbridge on 01/09/2025.
//

import Testing
@testable import iScream

struct ParentListChildrenBuilderTests {

    var mockUserService: MockUserService
    let router: ParentListChildrenRouter
    let interactor: ParentListChildrenInteractor
    let presenter: ParentListChildrenPresenterImp

    init() throws {
        mockUserService = MockUserService()
        router = ParentListChildrenRouterImp()
        interactor = ParentListChildrenInteractorImp(entity: ParentListChildrenEntityImp(), userService: mockUserService)
        presenter = ParentListChildrenPresenterImp(interactor: interactor, router: router)
    }

    @Test("POSITIVE - Can create a new parent list children module") func testFetch() throws {
        let builder = ParentListChildrenDefaultBuilder()
        let _ = builder.buildParentListChildrenView()
        try #require(builder.container.resolve(ParentListChildrenEntity.self) != nil)
        try #require(builder.container.resolve(ParentListChildrenInteractor.self) != nil)
        try #require(builder.container.resolve(ParentListChildrenRouter.self) != nil)
        try #require(builder.container.resolve(ParentListChildrenPresenter.self) != nil)
        try #require(builder.container.resolve(ParentListChildrenView.self) != nil)
        // TODO: When the opaque / boxing of the views look at this
//        try #require(testView as? RootContainerView != nil)
    }
}
