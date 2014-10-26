//
//  TSBaseViewController.swift
//  TingShuo
//
//  Created by fminor on 10/7/14.
//
//

import UIKit

let _indicator_width:CGFloat = 200.0
let _indicator_height:CGFloat = 100.0

class TSBaseViewController: UIViewController {
    
    var _indicatorView:UIView = UIView();

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // _indicator view
        _indicatorView.frame = CGRectMake(
            0.5 * (self.view.bounds.size.width - _indicator_width),
            0.5 * (self.view.bounds.size.height - _indicator_height),
            _indicator_width,
            _indicator_height
        );
        _indicatorView.alpha = 0;
        self.view .addSubview(_indicatorView);

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
