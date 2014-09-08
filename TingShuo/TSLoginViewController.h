//
//  TSLoginViewController.h
//  TingShuo
//
//  Created by fminor on 8/31/14.
//
//

#import <UIKit/UIKit.h>

extern NSString *TSLoginServerUrl;

@interface TSLoginViewController : UIViewController<UITextFieldDelegate>
{
    UIImageView                     *_backgroundImageView;
    UIView                          *_loginContainer;
    UITextField                     *_userNameTextField;
    UITextField                     *_passwordTextField;
    
    UIButton                        *_registerButton;
    UIButton                        *_forgetPwdButton;
    
    UIButton                        *_loginButton;
}

@end
