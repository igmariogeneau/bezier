//========================================
import UIKit
//========================================
class ViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    @IBOutlet weak var angle: UITextField!
    @IBOutlet weak var forScrollview: UIView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var circleGrid: UIImageView!
    var shape: BezierShape!
    var xPos: CGFloat = 0
    var yPos: CGFloat = 0
    var timer: Timer!
    var steps = 0
    var defaultX: CGFloat!
    var defaultY: CGFloat!
    var arrayOfAngles: [Double] = []
    let mathObj: Math = Math()
    //------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        fillArrayOfAngles()
    }
    //------------------------------------
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let width: CGFloat = CGFloat(10)
        let height: CGFloat = CGFloat(10)
        let xPos = self.forScrollview.frame.size.width/2 - width/2
        let yPos = self.circleGrid.frame.origin.y + 300 - 64
        shape = BezierShape(frame: CGRect(x: xPos, y: yPos, width: width, height: height))
        self.view.addSubview(shape)
        defaultX = shape.center.x
        defaultY = shape.center.y
    }
    //------------------------------------
    func fillArrayOfAngles() {
        var theAngle = 0.0
        for _ in 0...31 {
            arrayOfAngles.append(theAngle)
            theAngle += 11.25
        }
    }
    //------------------------------------
    @objc func sinCosAnimation() {
        if steps >= 384 {
            timer.invalidate()
            steps = 0
        }
        
        let angleInDegrees: Double = Double(angle.text!)!
        steps = steps + 1
        xPos = xPos + CGFloat(mathObj.returnValue("cos", [angleInDegrees/180.0])) / 500
        yPos = yPos + CGFloat(mathObj.returnValue("sin", [angleInDegrees/180.0])) / 500
//        xPos = xPos + CGFloat(__cospi(angleInDegrees/180.0)) / 500
//        yPos = yPos + CGFloat(__sinpi(angleInDegrees/180.0)) / 500
        shape.center.x += xPos
        shape.center.y += yPos
        
        shape.alpha = 1.0
    }
    //------------------------------------
    @IBAction func animate(_ sender: UIButton) {
        if angle.text == "" {
            return
        }
        angle.resignFirstResponder()
        scrollview.setContentOffset(CGPoint(x: 0, y:0), animated: true)
        xPos = 0
        yPos = 0
        shape.center.x = defaultX
        shape.center.y = self.circleGrid.frame.origin.y + 300 - 59
        steps = 0

        let angleDegrees: Double = Double(angle.text!)!
        let angleInRadians = CGFloat(angleDegrees * Double.pi/180) + CGFloat(90 * Double.pi/180)
        shape.transform = CGAffineTransform(rotationAngle: angleInRadians)
        
        timer = Timer.scheduledTimer(timeInterval: 0.005, target: self,
                                     selector: (#selector(ViewController.sinCosAnimation)),
                                     userInfo: nil, repeats: true)
    }
    //------------------------------------
    @IBAction func hideKeyboard(_ sender: UIButton) {
        angle.resignFirstResponder()
        scrollview.setContentOffset(CGPoint(x: 0, y:0), animated: true)
    }
    //------------------------------------
    @IBAction func randomAngle(_ sender: UIButton) {
        let randomAngle = mathObj.returnValue("rand", [Double(arrayOfAngles.count)])
//        let randomAngle = arc4random_uniform(UInt32(arrayOfAngles.count))
        angle.text = String(arrayOfAngles[Int(randomAngle)])
    }
    //------------------------------------
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        scrollview.setContentOffset(CGPoint(x: 0, y:200), animated: true)
    }
    //------------------------------------
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        shape.alpha = 0.0
    }
}
//========================================










