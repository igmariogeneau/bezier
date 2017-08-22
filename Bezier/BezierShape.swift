//====================================================
import UIKit
//====================================================
class BezierShape: UIView {
    var path: UIBezierPath!
    //------------------------------------------------
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.0)
    }
    //------------------------------------------------
    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
    }
    //------------------------------------------------
    override func draw(_ rect: CGRect) {
        path = UIBezierPath()
        createRectangle()
        UIColor.white.setFill()
        path.fill()
        UIColor.white.setStroke()
        path.lineWidth = 0.0
        path.stroke()
    }
    //------------------------------------------------
    func createCircle() {
        self.path = UIBezierPath(ovalIn: CGRect(x: self.frame.size.width/2 - self.frame.size.height/2 + 1,
                                                y: 1.0,
                                                width: self.frame.size.width - 2,
                                                height: self.frame.size.height - 2))
    }
    //------------------------------------------------
    func createTriangle() {
        path = UIBezierPath()
        path.move(to: CGPoint(x: self.frame.width/2, y: 0.0))
        path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        path.close()
    }
    //------------------------------------------------
    func createRectangle() {
        path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: 0.0))
        path.close()
    }
    //------------------------------------------------
}
//====================================================














