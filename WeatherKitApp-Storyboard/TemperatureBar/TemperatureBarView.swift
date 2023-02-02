import UIKit

@IBDesignable class TemperatureBarView: UIView {
    var view: UIView!
    var size: CGFloat = 100
    var position: CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        loadViewFromNib()
    }
    
    override func draw(_ rect: CGRect) {
        drawTemperatureBar(height: 10, inView: view)
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib();
        self.backgroundColor = .clear
        view.backgroundColor = .clear
        size = CGFloat.random(in: 0...view.frame.width)
        position = CGFloat.random(in: 0...view.frame.width)
    }

    func loadViewFromNib(){
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        view.autoresizingMask = [
            UIView.AutoresizingMask.flexibleHeight,
            UIView.AutoresizingMask.flexibleWidth
        ]
        addSubview(view)
        self.view = view
    }
    
    func drawTemperatureBar(height: CGFloat, inView: UIView){
        let cornerRadius = 5.0
        let backgroundShape = CAShapeLayer()
        let backgroundFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: height)
        let backgroundPath = UIBezierPath(roundedRect: backgroundFrame, cornerRadius: cornerRadius)
        
        backgroundShape.path = backgroundPath.cgPath
        backgroundShape.fillColor = UIColor.lightGray.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        
        gradientLayer.frame = backgroundFrame
        gradientLayer.colors = [UIColor.systemTeal.cgColor, UIColor.cyan.cgColor, UIColor.yellow.cgColor, UIColor.orange.cgColor]
        gradientLayer.cornerRadius = cornerRadius
        
        let maskShape = CAShapeLayer()
        let maskFrame = CGRect(x: position, y: 0, width: size, height: height)
        let maskPath = UIBezierPath(roundedRect: maskFrame, cornerRadius: cornerRadius)
        
        maskShape.path = maskPath.cgPath
        gradientLayer.mask = maskShape
        
        backgroundShape.addSublayer(gradientLayer)
        backgroundShape.position = CGPoint(x: frame.minX, y: frame.midY - height / 2)
        backgroundShape.opacity = 0.4
        self.view.layer.addSublayer(backgroundShape)
    }
}

