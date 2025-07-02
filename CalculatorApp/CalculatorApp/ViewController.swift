//
//  ViewController.swift
//  CalculatorApp
//
//  Created by nika razmadze on 02.07.25.
//

import UIKit

class CalculatorViewController: UIViewController {

    //MARK: - Properties
    private let displayLabel = UILabel()

    private var currentInput: String = ""
    private var previousValue: Double?
    private var currentOperation: String?

    private let buttonTitles: [[String]] = [
        ["7", "8", "9", "/"],
        ["4", "5", "6", "*"],
        ["1", "2", "3", "-"],
        ["C", "0", "=", "+"]
    ]

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupDisplayLabel()
        setupButtons()
    }

    //MARK: - Private Methods
    private func setupDisplayLabel() {
        displayLabel.frame = CGRect(x: 0, y: 80, width: view.frame.width, height: 100)
        displayLabel.backgroundColor = .black
        displayLabel.textColor = .white
        displayLabel.font = UIFont.systemFont(ofSize: 36)
        displayLabel.textAlignment = .right
        displayLabel.text = "0"
        view.addSubview(displayLabel)
    }

    private func setupButtons() {
        let buttonWidth: CGFloat = view.frame.width / 4
        let buttonHeight: CGFloat = 80
        let startY: CGFloat = 180

        for (rowIndex, row) in buttonTitles.enumerated() {
            for (colIndex, title) in row.enumerated() {
                let button = UIButton(frame: CGRect(
                    x: CGFloat(colIndex) * buttonWidth,
                    y: startY + CGFloat(rowIndex) * buttonHeight,
                    width: buttonWidth,
                    height: buttonHeight
                ))

                button.setTitle(title, for: .normal)
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = .orange
                button.titleLabel?.font = UIFont.systemFont(ofSize: 28)
                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)

                view.addSubview(button)
            }
        }
    }

    @objc private func buttonTapped(_ sender: UIButton) {
        guard let title = sender.currentTitle else { return }

        switch title {
        case "0"..."9":
            currentInput += title
            displayLabel.text = currentInput

        case "+", "-", "*", "/":
            if let value = Double(currentInput) {
                previousValue = value
                currentInput = ""
                currentOperation = title
            }

        case "=":
            if let operation = currentOperation,
               let previous = previousValue,
               let current = Double(currentInput) {

                let result: String
                switch operation {
                case "+": result = String(previous + current)
                case "-": result = String(previous - current)
                case "*": result = String(previous * current)
                case "/":
                    if current == 0 {
                        result = "Divide by 0? 🙈"
                    } else {
                        result = String(previous / current)
                    }
                default: result = "Error"
                }

                displayLabel.text = result
                currentInput = result
                previousValue = nil
                currentOperation = nil
            }

        case "C":
            currentInput = ""
            previousValue = nil
            currentOperation = nil
            displayLabel.text = "0"

        default:
            break
        }
    }
}


