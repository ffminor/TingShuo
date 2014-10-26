//
//  TSRegisterUserInfoViewController.swift
//  TingShuo
//
//  Created by fminor on 9/27/14.
//
//

import UIKit

// http://42.121.144.167/?type=modify&acc=12345&psw=45634&item=nk&value=test1

class TSRegisterUserInfoViewController:
    TSBaseViewController,
    UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @IBOutlet weak var _nickNameTextField: UITextField!
    @IBOutlet weak var _uploadButton: UIButton!
    
    var account:String = "";
    var password:String = "";
    
    var _imagePickerController:UIImagePickerController = UIImagePickerController();
    var _rightManageButton:UIButton = UIButton(frame: CGRectMake(0, 0, 60, 30));
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _uploadButton.layer.cornerRadius = 0.5 * _uploadButton.bounds.size.width;
        _uploadButton.clipsToBounds = true;
        
        _rightManageButton.titleLabel?.font = UIFont(name: "", size: 12);
        _rightManageButton.setTitle("完成", forState: UIControlState.Normal);
        _rightManageButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        _rightManageButton.addTarget(self, action: "_actionFinishRegsiter",
                                    forControlEvents: UIControlEvents.TouchUpInside);
        
        let _rightBarButton = UIBarButtonItem(customView: _rightManageButton);
        self.navigationItem.setRightBarButtonItem(_rightBarButton, animated: false);

        _nickNameTextField.delegate = self;
        _imagePickerController.delegate = self;
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.setNavigationBarHidden(false, animated: false);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
    // button actions
    //

    @IBAction func _actionUploadBtn(sender: AnyObject) {
        var _sheet:UIActionSheet = UIActionSheet(title: "上传图片", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: "从手机相册上传");
        _sheet.showInView(self.view);
    }
    
    func _actionFinishRegsiter() {
        println("准备上传注册信息...");
        let _nkName:String = _nickNameTextField.text;
        let _imagePath:String = "";
        
        var _uploader:QiniuSimpleUploader = QiniuSimpleUploader();
        
        var _urlStr:String = "http://42.121.144.167/?type=modify&acc=" + account + "&psw=" + password + "&item=nk&value=" + _nkName;
        println("url:\(_urlStr)");
        if let _url = NSURL(string: _urlStr) {
            let _urlReq = NSURLRequest(URL: _url);
            
            var _request:AFHTTPRequestOperation = AFHTTPRequestOperation(request: _urlReq)
            _request.setCompletionBlockWithSuccess({ (AFHTTPRequestOperation, AnyObject) -> Void in
                var _dataStr:String? = NSString(data:AnyObject as NSData , encoding: NSUTF8StringEncoding)
                if ( _dataStr == "modify ok." ) {
                    
                    println("register ok!");
                    self.navigationController?.setNavigationBarHidden(true, animated: false);
                    
                    var _storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    var _tabBarController:TSTabBarController = _storyBoard.instantiateViewControllerWithIdentifier("maintabbar") as TSTabBarController;
                    self.navigationController?.pushViewController(_tabBarController, animated: true);
                    
                } else {
                    
                }
                }, failure: { (AFHTTPRequestOperation, NSError) -> Void in
                    println(NSError);
            })
            _request.start()
        }
    }
    
    //
    // action sheet delegate
    //
    
    func actionSheet(actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        let _logStr:String = "press button\(buttonIndex)";
        println(_logStr);
        
        // self.navigationController?.pushViewController(_imagePickerController, animated: true);
        self.presentViewController(_imagePickerController, animated: true, completion:nil)
    }
    
    //
    // image picker delegate
    //

    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        println("image picker delegate!");
        picker.popViewControllerAnimated(true);
        _uploadButton.setImage(image, forState: UIControlState.Normal);
    }
}
