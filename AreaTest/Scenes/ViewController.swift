import UIKit

final class ViewController: UIViewController {
    
    private lazy var shapeTextField: UITextField = {
        let field = UITextField()
        field.textColor = .black
        field.backgroundColor = .lightGray
        field.layer.cornerRadius = 10
        field.layer.masksToBounds = true
        field.attributedPlaceholder = NSAttributedString(
            string: "Input shape name (square, triangle or cycle)",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        field.setLeftPaddingPoints(10)
        field.setRightPaddingPoints(10)
        field.frame = CGRect(
            x: 10,
            y: view.safeAreaInsets.top + 100,
            width: view.frame.width - 20,
            height: 25
        )
        return field
    }()
    
    private lazy var firstSizeTextField: UITextField = {
        let field = UITextField()
        field.textColor = .black
        field.backgroundColor = .lightGray
        field.layer.cornerRadius = 10
        field.layer.masksToBounds = true
        field.attributedPlaceholder = NSAttributedString(
            string: "Input first size (radius for cycle)",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        field.setLeftPaddingPoints(10)
        field.setRightPaddingPoints(10)
        field.frame = CGRect(
            x: 10,
            y: shapeTextField.frame.maxY + 10,
            width: view.frame.width - 20,
            height: 25
        )
        return field
    }()
    
    private lazy var secondSizeTextField: UITextField = {
        let field = UITextField()
        field.textColor = .black
        field.backgroundColor = .lightGray
        field.layer.cornerRadius = 10
        field.layer.masksToBounds = true
        field.attributedPlaceholder = NSAttributedString(
            string: "Input second size (leave empty for square)",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        field.setLeftPaddingPoints(10)
        field.setRightPaddingPoints(10)
        field.frame = CGRect(
            x: 10,
            y: firstSizeTextField.frame.maxY + 10,
            width: view.frame.width - 20,
            height: 25
        )
        return field
    }()
    
    private lazy var thirdSizeTextField: UITextField = {
        let field = UITextField()
        field.textColor = .black
        field.backgroundColor = .lightGray
        field.layer.cornerRadius = 10
        field.layer.masksToBounds = true
        field.attributedPlaceholder = NSAttributedString(
            string: "Input third size (only for triangle)",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        field.setLeftPaddingPoints(10)
        field.setRightPaddingPoints(10)
        field.frame = CGRect(
            x: 10,
            y: secondSizeTextField.frame.maxY + 10,
            width: view.frame.width - 20,
            height: 25
        )
        return field
    }()
    
    private lazy var calculateButton: UIButton = {
        let button = UIButton()
        button.addTarget(
            self,
            action: #selector(calculateButtonPressed),
            for: .touchUpInside)
        button.setTitle("Calculate", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.frame = CGRect(
            x: view.frame.width / 2 - 50,
            y: thirdSizeTextField.frame.maxY + 10,
            width: 100,
            height: 50
        )
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "Result is:"
        label.textColor = .black
        label.frame = CGRect(
            x: 10,
            y: calculateButton.frame.maxY + 10,
            width: view.frame.width - 20,
            height: 25
        )
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
    }
    
    private func addSubviews() {
        view.addSubview(shapeTextField)
        view.addSubview(firstSizeTextField)
        view.addSubview(secondSizeTextField)
        view.addSubview(thirdSizeTextField)
        view.addSubview(calculateButton)
        view.addSubview(resultLabel)
    }
    
    private enum Shapes: String {
        case square = "Square"
        case cycle = "Cycle"
        case triangle = "Triangle"
    }
    
    private enum Strings: String {
        case resultIs = "Result is: "
        case wrongShape = "Wrong shape!"
    }
    
    @objc
    private func calculateButtonPressed() {
        switch shapeTextField.text?.lowercased() {
        case Shapes.square.rawValue.lowercased():
            resultLabel.text = calculateSquare(
                firstSize: firstSizeTextField.text,
                secondSize: secondSizeTextField.text
            )
        case Shapes.cycle.rawValue.lowercased():
            resultLabel.text = calculateCycle(
                firstSize: firstSizeTextField.text
            )
        case Shapes.triangle.rawValue.lowercased():
            resultLabel.text = calculateTriangle(
                firstSize: firstSizeTextField.text,
                secondSize: secondSizeTextField.text,
                thirdSize: thirdSizeTextField.text
            )
        default:
            resultLabel.text = Strings.resultIs.rawValue +
            Strings.wrongShape.rawValue
        }
    }
    
    private func calculateSquare(firstSize: String?, secondSize: String?) -> String {
        guard let firstSize else { return "First size is nil!" }
        guard let secondSize else { return "Second size is nil!" }
        guard let firstSide: Float = Float(firstSize) else { return "First size wrong value!" }
        guard let secondSide: Float = Float(secondSize) else { return "Second size wrong value!"}
        let squareArea: Float = firstSide * secondSide
        let area: String = String(squareArea)
        return Strings.resultIs.rawValue + area
    }
    
    private func calculateCycle(firstSize: String?) -> String {
        guard let firstSize else { return "First size is nil!" }
        let piValue = Float.pi
        guard let radius = Float(firstSize) else { return "First size wrong value!" }
        let cycleArea: Float = piValue * (radius * radius)
        let area: String = String(cycleArea)
        return Strings.resultIs.rawValue + area
    }
    
    private func calculateTriangle(firstSize: String?, secondSize: String?, thirdSize: String?) -> String {
        guard let firstSize else { return "First size is nil!" }
        guard let secondSize else { return "Second size is nil!" }
        guard let thirdSize else { return "Third size is nil!" }
        guard let firstSide: Double = Double(firstSize) else { return "First size wrong value!" }
        guard let secondSide: Double = Double(secondSize) else { return "Second size wrong value!" }
        guard let thirdSide: Double = Double(thirdSize) else { return "Third size wrong value!" }
        let halfPerimeter: Double = (firstSide + secondSide + thirdSide) / 2
        let cycleAreaGeronFormula = sqrt(halfPerimeter * (halfPerimeter - firstSide) * (halfPerimeter - secondSide) * (halfPerimeter - thirdSide))
        let area: String = String(cycleAreaGeronFormula)
        return Strings.resultIs.rawValue + area
    }
}

