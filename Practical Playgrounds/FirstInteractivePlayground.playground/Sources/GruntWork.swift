import Foundation
import UIKit

public class DemoView: UIView
{
    let originalColor: UIColor
    public init(backgroundColor: UIColor)
    {
        originalColor = backgroundColor
        
        super.init(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        
        self.backgroundColor = backgroundColor
        layer.cornerRadius = frame.height / 2
        
        let button = UIButton(type: .Custom)
        button.setTitle("Click me!", forState: .Normal)
        button.frame = frame
        button.center = center
        button.setTitle("Ooh, matron!", forState: .Highlighted)
        
        // Note, use of #selector(<function name>), won't compile if method doesn't exist
        // Huge improvement on Selector("buttonClicked") <- no more 'stringly-typed' method names
        button.addTarget(self, action: #selector(buttonClicked), forControlEvents: .TouchDown)
        button.addTarget(self, action: #selector(buttonReleased), forControlEvents: .TouchUpInside)
        
        addSubview(button)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buttonClicked()
    {
        print("Button was clicked!")
        backgroundColor = .magentaColor()
    }
    
    func buttonReleased()
    {
        backgroundColor = originalColor
    }
}