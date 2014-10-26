//
//  TSRegisterViewController.swift
//  TingShuo
//
//  Created by fminor on 9/14/14.
//
//

import UIKit
// import TSRegisterUserInfoViewController

let TSLoginServerUrl                    = "http://42.121.144.167/?type=reg&acc=123&pwd=456"
let TSRegisterServerUrl                 = "http://42.121.144.167/?type=logon&name=123&pwd=456"

class TSRegisterViewController:TSBaseViewController,
    UITextFieldDelegate
{

    @IBOutlet weak var _emailTextField: UITextField!
    @IBOutlet weak var _pwdTextField: UITextField!
    @IBOutlet weak var _registerButton: UIButton!
    @IBOutlet weak var _container: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let _gesture = UIPanGestureRecognizer(target: self, action:"_actionPan")
        self.view.addGestureRecognizer(_gesture)
        
        let _tapGesture = UITapGestureRecognizer(target: self, action: "_actionTap")
        self.view.addGestureRecognizer(_tapGesture)
        
        self._emailTextField.delegate = self;
        self._pwdTextField.delegate = self;
        
        self.view.backgroundColor = UIColor(red:0.95 , green: 0.95, blue: 0.95, alpha: 1.0);
        
        // next step button
        var _nextStepButton:UIButton = UIButton(frame: CGRectMake(0, 0, 60, 40));
        _nextStepButton.setTitle("下一步", forState: UIControlState.Normal);
        _nextStepButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        _nextStepButton.titleLabel?.font = UIFont(name: "", size: 12);
        var _rightBarButton:UIBarButtonItem = UIBarButtonItem(customView: _nextStepButton);
        self.navigationItem.setRightBarButtonItem(_rightBarButton, animated: false);
        _nextStepButton.addTarget(self, action: "_actionRegister:", forControlEvents: UIControlEvents.TouchUpInside);
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.translucent = false;
        self.navigationController?.navigationBarHidden = false;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func actionRegister() {
        let _email = _emailTextField?.text;
        let _pwd = _pwdTextField?.text;
    }
    
    func _actionPan() {
        _emailTextField.resignFirstResponder()
        _pwdTextField.resignFirstResponder()
    }
    
    func _actionTap() {
        _emailTextField.resignFirstResponder()
        _pwdTextField.resignFirstResponder()
        
        self._actionRegister(self)
    }
    
    func _actionRegisterSuccess() {
        var _storyBoard:UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        var _userInfoViewController: TSRegisterUserInfoViewController = _storyBoard.instantiateViewControllerWithIdentifier("registerUserInfo") as TSRegisterUserInfoViewController
        _userInfoViewController.account = _emailTextField.text;
        _userInfoViewController.password = _pwdTextField.text;
        self.navigationController?.pushViewController(_userInfoViewController, animated: true)
    }
    
    func _actionRegisterFailed() {
        
    }
    
    @IBAction func _actionRegister(sender: AnyObject) {
        let _email:NSString? = _emailTextField?.text;
        let _pwd:NSString? = _pwdTextField?.text;
        
        var _urlStr:String = "http://42.121.144.167/?type=reg&acc=" + _email! + "&psw=" + _pwd!
        let _urlReq:NSURLRequest = NSURLRequest(URL: NSURL(string: _urlStr)!)
        var _request:AFHTTPRequestOperation = AFHTTPRequestOperation(request: _urlReq)
        _request.setCompletionBlockWithSuccess({ (AFHTTPRequestOperation, AnyObject) -> Void in
            var _dataStr:String = NSString(data:AnyObject as NSData , encoding: NSUTF8StringEncoding)!
            if ( _dataStr == "regist ok." ) {
                self._actionRegisterSuccess()
            } else {
            }
        }, failure: { (AFHTTPRequestOperation, NSError) -> Void in
            
        })
        _request.start()
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        UIView.animateWithDuration(0.2,  animations: { () -> Void in
            var _transform:CGAffineTransform = CGAffineTransformMakeTranslation(0, -120)
            self._container.transform = _transform
        })
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        UIView.animateWithDuration(0.2,  animations: { () -> Void in
            var _transform:CGAffineTransform = CGAffineTransformIdentity
            self._container.transform = _transform
        })
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
