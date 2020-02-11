//
//  TaskItemView.swift
//  SiriKitDemo
//
//  Created by Andres Rojas on 22/01/20.
//  Copyright © 2020 Andres Rojas. All rights reserved.
//

import UIKit
import IntentsUI

class TaskItemView: UIView {

    // MARK: - UI Components

    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        label.textAlignment = .center

        return label
    }()

    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        textView.isEditable = true
        textView.layer.cornerRadius = 5
        textView.font = UIFont.systemFont(ofSize: 16)

        return textView
    }()

    lazy var shortcut: INUIAddVoiceShortcutButton = {
        let activity = ActivityHelper.getNewTaskActivity()
        let shortcut = INShortcut(userActivity: activity)

        let button = INUIAddVoiceShortcutButton(style: .whiteOutline)
        button.shortcut = shortcut
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK:- Helpers

    private func setupUI() {
        addSubview(label)
        addSubview(textView)
        addSubview(shortcut)

        NSLayoutConstraint.activate([

            shortcut.topAnchor.constraint(equalTo: readableContentGuide.topAnchor, constant: 8),
            shortcut.centerXAnchor.constraint(equalTo: centerXAnchor),

            label.topAnchor.constraint(equalTo: shortcut.topAnchor, constant: 30),
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            label.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),

            textView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16),
            textView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            textView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            textView.heightAnchor.constraint(equalTo: textView.widthAnchor, multiplier: 0.8)
        ])
    }
}
