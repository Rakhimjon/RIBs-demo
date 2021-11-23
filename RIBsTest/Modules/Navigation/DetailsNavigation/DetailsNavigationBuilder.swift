//
//  DetailsNavigationBuilder.swift
//  RIBsTest
//
//  Created by Oleksii Voitenko on 20.11.2021.
//

import RIBs

public enum DetailsNavigationPayload {
    case movie(Movie)
    case actor(Actor)
}

protocol DetailsNavigationDependency: MovieDetailsDependency, ActorDetailsDependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class DetailsNavigationComponent: Component<DetailsNavigationDependency> {
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol DetailsNavigationBuildable: Buildable {
    func build(with payload: DetailsNavigationPayload, and listener: DetailsNavigationListener) -> DetailsNavigationRouting
}

final class DetailsNavigationBuilder: Builder<DetailsNavigationDependency>, DetailsNavigationBuildable {
    override init(dependency: DetailsNavigationDependency) {
        super.init(dependency: dependency)
    }

    func build(with payload: DetailsNavigationPayload, and listener: DetailsNavigationListener) -> DetailsNavigationRouting {
        let viewController = DetailsNavigationViewController()
        let interactor = DetailsNavigationInteractor(payload: payload, presenter: viewController)
        interactor.listener = listener
        
        let movieDetailsBuildable = MovieDetailsBuilder(dependency: dependency)
        let actorDetailsBuildable = ActorDetailsBuilder(dependency: dependency)
        
        return DetailsNavigationRouter(
            interactor: interactor,
            movieDetailsBuildable: movieDetailsBuildable,
            actorDetailsBuildable: actorDetailsBuildable,
            viewController: viewController
        )
    }
}
