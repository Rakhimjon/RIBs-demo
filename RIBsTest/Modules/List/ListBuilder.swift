//
//  ListBuilder.swift
//  RIBsTest
//
//  Created by Oleksii Voitenko on 28.10.2021.
//

import RIBs

struct ListItem {
    let image: UIImage
    let title: String
}

protocol ListDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class ListComponent: Component<ListDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol ListBuildable: Buildable {
    func build(with items: [ListItem], title: String, listener: ListListener) -> ListRouting
}

final class ListBuilder: Builder<ListDependency>, ListBuildable {

    override init(dependency: ListDependency) {
        super.init(dependency: dependency)
    }

    func build(with items: [ListItem], title: String, listener: ListListener) -> ListRouting {
        let viewController = ListViewController()
        viewController.title = title
        let interactor = ListInteractor(items: items, presenter: viewController)
        interactor.listener = listener
        return ListRouter(interactor: interactor, viewController: viewController)
    }
}
