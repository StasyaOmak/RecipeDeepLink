// RecipesView copy.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol RecipesViewInput: AnyObject {}

final class RecipesView: UIViewController {
    // MARK: - Public

    var presenter: RecipesPresenterInput?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

extension RecipesView: RecipesViewInput {}

#Preview {
    let view = RecipesView()

    let presenter = RecipesPresenter()
    view.presenter = presenter
    return view
}
