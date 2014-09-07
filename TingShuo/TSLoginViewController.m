//
//  TSLoginViewController.m
//  TingShuo
//
//  Created by fminor on 8/31/14.
//
//

#import "TSLoginViewController.h"
#import "AFNetworking.h"

NSString *TSLoginServerUrl                  = @"http://42.121.144.167/?type=reg&acc=123&pwd=456";
NSString *TSRegisterServerUrl               = @"http://42.121.144.167/?type=logon&name=123&pwd=456";

#define TS_LOGIN_URL(userid, pwd)           [NSString stringWithFormat:@"http://42.121.144.167/?type=logon&name=%@&pwd=%@", userid, pwd]

@interface TSLoginViewController ()

@end

@implementation TSLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setHidden:YES];
    
    _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_bkg.jpg"]];
    [self.view addSubview:_backgroundImageView];
    
    _userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(110, 295, 130, 30)];
    [_userNameTextField.layer setBorderColor:[UIColor blackColor].CGColor];
    [_userNameTextField.layer setBorderWidth:1.0f];
    _userNameTextField.delegate = self;
    [self.view addSubview:_userNameTextField];
    
    CGRect _user_frame = _userNameTextField.frame;
    _user_frame.origin.y += 43;
    _passwordTextField = [[UITextField alloc] initWithFrame:_user_frame];
    [_passwordTextField.layer setBorderWidth:1.0f];
    [_passwordTextField.layer setBorderColor:[UIColor blackColor].CGColor];
    _passwordTextField.delegate = self;
    [self.view addSubview:_passwordTextField];
    
    UIPanGestureRecognizer *_panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(_actionPan)];
    [self.view addGestureRecognizer:_panGesture];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_actionPan
{
    [_userNameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *_userId = _userNameTextField.text;
    NSString *_pwd = _passwordTextField.text;
    
    NSString *_url_str = TS_LOGIN_URL(_userId, _pwd);
    NSURL *_url = [NSURL URLWithString:_url_str];
    
    AFHTTPRequestOperation *_requset = [[AFHTTPRequestOperation alloc]
                                        initWithRequest:[NSURLRequest requestWithURL:_url]];
    [_requset setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"登录请求成功！请求链接：%@", _url);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"登录请求失败！请求链接：%@", _url);
    }];
    
    [_requset start];
    return YES;
}

@end
