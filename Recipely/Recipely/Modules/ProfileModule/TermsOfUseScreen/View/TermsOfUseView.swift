// TermsOfUseView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс взаимодействия с TermsOfUseView
protocol TermsOfUseViewProtocol: AnyObject {}

/// Вью экрана правил использования
final class TermsOfUseView: UIViewController {
    // MARK: - Types

    /// Состояние показа основного вью экрана
    enum CardState {
        /// Вью развернуто
        case expanded
        /// Вью свернуто
        case collapsed
        /// Вью показано на половину
        case halfExpanded

        /// Следующее состояние
        var next: CardState {
            switch self {
            case .expanded:
                .collapsed
            case .collapsed:
                .halfExpanded
            case .halfExpanded:
                .expanded
            }
        }
    }

    // MARK: - Visual Components

    private let termsView = TermsView()
    private var visualBackgroundView = UIVisualEffectView()
    private lazy var handleAreaView = {
        let view = UIView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCardTap(_:)))
        view.addGestureRecognizer(tapGesture)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(_:)))
        view.addGestureRecognizer(panGesture)
        return view
    }()

    // MARK: - Public Properties

    var presenter: TermsOfUsePresenterProtocol?

    // MARK: - Private Properties

    private var cardIsVisible = false
    private var currentState = CardState.halfExpanded
    private var nextState: CardState {
        currentState = currentState.next
        return currentState
    }

    private var runningAnimations: [UIViewPropertyAnimator] = []
    private var animationProgressWhenInterrupted = 0.0

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateTransitionIfNeeded(state: .halfExpanded, duration: 0.9)
    }

    deinit {
        print("deinit ", String(describing: self))
    }

    // MARK: - Private Methods

    private func configureUI() {
        view.backgroundColor = .clear
        visualBackgroundView.frame = view.frame
        termsView.addSubview(handleAreaView)
        view.addSubviews(visualBackgroundView, termsView)
    }

    private func configureLayout() {
        termsView.frame = CGRect(
            x: 0,
            y: view.frame.height,
            width: view.frame.width,
            height: view.frame.height - 100
        )
        UIView.doNotTAMIC(for: handleAreaView)
        handleAreaViewConfigureLayout()
    }

    private func handleAreaViewConfigureLayout() {
        [
            handleAreaView.topAnchor.constraint(equalTo: termsView.topAnchor),
            handleAreaView.heightAnchor.constraint(equalToConstant: 34),
            handleAreaView.leadingAnchor.constraint(equalTo: termsView.leadingAnchor),
            handleAreaView.trailingAnchor.constraint(equalTo: termsView.trailingAnchor)
        ].activate()
    }

    private func animateTransitionIfNeeded(state: CardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.termsView.frame.origin.y = self.view.frame.height - self.termsView.frame.height
                case .collapsed:
                    self.termsView.frame.origin.y = self.view.frame.height
                case .halfExpanded:
                    self.termsView.frame.origin.y = self.view.frame.height / 2
                }
            }
            frameAnimator.addCompletion { _ in
                self.cardIsVisible.toggle()
                self.runningAnimations.removeAll()
                if case .collapsed = state {
                    self.presenter?.viewDisappearedUnderScreen()
                }
            }
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)

            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                let cornerRadius = state == .expanded ? 30.0 : 0.0
                self.termsView.layer.cornerRadius = cornerRadius
            }
            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)

            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                let effect = state == .expanded ? UIBlurEffect(style: .dark) : nil
                self.visualBackgroundView.effect = effect
            }
            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
        }
    }

    private func startInteractiveTransition(state: CardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }

    private func updateInteractiveTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }

    private func continueInteractiveTransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }

    @objc private func handleCardTap(_ recogrizer: UITapGestureRecognizer) {
        animateTransitionIfNeeded(state: .collapsed, duration: 0.4)
    }

    @objc private func handleCardPan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            let translation = recognizer.translation(in: handleAreaView)
            var fractionComplete = translation.y / termsView.frame.height

            switch currentState {
            case .collapsed:
                break
            case .halfExpanded, .expanded:
                fractionComplete = -fractionComplete
            }
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
    }
}

extension TermsOfUseView: TermsOfUseViewProtocol {}
