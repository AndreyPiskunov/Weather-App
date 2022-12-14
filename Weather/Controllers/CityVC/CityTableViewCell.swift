//
//  CityTableViewCell.swift
//  Weather
//
//  Created by Andrey Piskunov on 13.10.2022.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    enum GradientColors {
        case day, night, fog, blank
    }
    
    @IBOutlet weak var cityTimeLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var weatherBackgroundView: UIView!
    
    private let gradient = CAGradientLayer()
    private let cellShapeMask = UIView()
    
    override var isHighlighted: Bool {
             didSet{
                 //Animate this cell by highlight
                 bounce(isHighlighted)
             }
         }
    
    // MARK: - Lifecycle
         
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        //Configuring gradient frame when views calculating
        gradient.frame = weatherBackgroundView.bounds
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        //Setting up cell shape
        setCellComponentShape(view: weatherBackgroundView.layer)
        
        //Making shadow
        weatherBackgroundView.layer.shadowColor = UIColor.black.cgColor
        weatherBackgroundView.layer.shadowOpacity = 0.2
        weatherBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 3)
        weatherBackgroundView.layer.shadowRadius = 7
        
        //Making cells shadow be able to spill over other cells
        layer.masksToBounds = false
        backgroundColor = .clear
        
        //Setting up gradient layer
        gradient.startPoint = CGPoint(x: 0.0, y: 0.1)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
        gradient.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]
        
        setGradient(withStyle: .blank)

        weatherBackgroundView.layer.insertSublayer(gradient, at: 0) //Adding gradient
        
    }
    
    func setGradient(withStyle style: GradientColors) {
        
        switch style {
        case .day: gradient.colors = [UIColor(red: 68/255, green: 166/255, blue: 252/255, alpha: 1).cgColor,
                                      UIColor(red: 114/255, green: 225/255, blue: 253/255, alpha: 1).cgColor]
        case .fog: break
        case .night: gradient.colors = [UIColor(red: 9/255, green: 7/255, blue: 40/255, alpha: 1).cgColor,
                                        UIColor(red: 30/255, green: 94/255, blue: 156/255, alpha: 1).cgColor]
        case .blank: gradient.colors = nil
        }
    }
    
    private func setCellComponentShape(view: CALayer) {
        
        //Making proper round corners
        view.cornerCurve = CALayerCornerCurve.continuous
        view.cornerRadius = 15
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //Cell bounce animation
    func bounce(_ bounce: Bool){
        
        //Animation settings and allowing user to interact while the animation is running
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 1.0,
                       options: [.curveEaseInOut,.allowUserInteraction],
                       animations: {
            
            self.transform = bounce ? CGAffineTransform(scaleX: 0.95, y: 0.95) : CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
            
        }, completion: nil)
    }
}
