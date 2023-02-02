import UIKit

@IBDesignable class TemperatureBarView: UIView {
    var view: UIView!
    var size: CGFloat = 50
    var position: CGFloat = 0
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBAction func sliderChanged(_ sender: UISlider) {
        size = CGFloat(sender.value)
        label.text = size.description
        self.setNeedsDisplay()
    }
    
    @IBOutlet weak var slider2: UISlider!
    @IBAction func slider2(_ sender: UISlider) {
        position = CGFloat(sender.value)
        self.setNeedsDisplay()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        loadViewFromNib()
    }
    
    override func draw(_ rect: CGRect) {
        draw(height: 10, cornerRadius: 5, inView: view)
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib();
        self.backgroundColor = .clear
        view.backgroundColor = .clear
       
        slider.minimumValue = 0
        slider.maximumValue = Float(view.frame.width)
        slider.value = 0
        
        slider2.minimumValue = 0
        slider2.maximumValue = Float(view.frame.width - size)
        slider2.value = 0
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
    
    
    
    
    func draw(height: CGFloat, cornerRadius: CGFloat, inView: UIView){
        
        
        
        let backgroundShape = CAShapeLayer()
        let backgroundFrame = CGRect(x: 0, y: 0, width: frame.width, height: height)
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
        let maskFrame = CGRect(x: 0, y: 0, width: size, height: height)
        let maskPath = UIBezierPath(roundedRect: maskFrame, cornerRadius: cornerRadius)
        
        maskShape.path = maskPath.cgPath
        gradientLayer.mask = maskShape
        maskShape.position = CGPoint(x: position, y: 0)
        
        backgroundShape.addSublayer(gradientLayer)
        backgroundShape.position = CGPoint(x: 0, y: view.center.y)
        self.view.layer.addSublayer(backgroundShape)
    }
}

