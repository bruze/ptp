//
//  Settings.swift
//  ptplayer
//
//  Created by Bruno Garelli on 2/23/17.
//
//

import UIKit
@objc class Settings: UIView {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var points: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    convenience init() {
        self.init(frame: CGRect.zero)
    }
}
