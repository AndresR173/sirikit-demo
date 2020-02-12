//
//  TaskItemViewController.swift
//  SiriKitDemo
//
//  Created by Andres Rojas on 22/01/20.
//  Copyright © 2020 Andres Rojas. All rights reserved.
//

import UIKit
import IntentsUI

protocol TaskItemDelegate: class {
    func didSaveTask(task: Task)
}

class TaskItemViewController: BaseViewController<TaskItemView> {

    // MARK: - UI Components

    private lazy var saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))

    // MARK: - Properties

    var task: Task?

    weak var delegate: TaskItemDelegate?

    // MARK: - Initializer

    init(_ task: Task? = nil) {
        self.task = task

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationItem.largeTitleDisplayMode = .never
    }

}

// MARK: - Herlpers

extension TaskItemViewController {
    @objc private func save() {
        if self.task != nil {
            self.task?.title = customView.textView.text
            delegate?.didSaveTask(task: task!)
        } else {
            let task = Task(id: UUID(), title: customView.textView.text, isDone: false)
            delegate?.didSaveTask(task: task)
            donateActivity()
            donateIntent()
        }

        navigationController?.popViewController(animated: true)
    }

    private func setupUI() {
        if let task = self.task {
            customView.label.text = "Edit Task"
            customView.textView.text = task.title
        } else {
            customView.label.text = "New Task"
        }
        customView.shortcut.delegate = self
        navigationItem.rightBarButtonItem = saveButton
    }

    private func donateActivity() {
        let activity = ActivityHelper.getNewTaskActivity()

        view.userActivity = activity
        activity.becomeCurrent()
    }

    private func donateIntent() {
        let intent = AddTaskIntent()
        let interaction = INInteraction(intent: intent, response: nil)
        interaction.donate(completion: nil)
    }
}

extension TaskItemViewController: INUIAddVoiceShortcutButtonDelegate {
    func present(_ addVoiceShortcutViewController: INUIAddVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        addVoiceShortcutViewController.delegate = self
        present(addVoiceShortcutViewController, animated: true)
    }

    func present(_ editVoiceShortcutViewController: INUIEditVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {

    }
}

extension TaskItemViewController: INUIAddVoiceShortcutViewControllerDelegate {
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true)
    }

    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true)
    }


}
