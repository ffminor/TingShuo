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

NSString *kTSLoginFailed                    = @"logon failed.";

#define TS_LOGIN_URL(userid, pwd)           [NSString stringWithFormat:@"http://42.121.144.167/?type=logon&acc=%@&psw=%@", userid, pwd]
#define TS_REGISTER_URL(userid, pwd)        [NSString stringWithFormat:@"http://42.121.144.167/?type=reg&namw=%@&pwd=%@", userid, pwd]

#define LOG_CONTAINER_X                     65.f
#define LOG_CONTAINER_Y                     285.f
#define LOG_CONTAINER_H                     90.f

#define LOG_SEPERATOR_MARGIN                8.f
#define LOG_SEPERATOR_COLOR                 [UIColor colorWithRed:(CGFloat)0x7F/0xFF green:(CGFloat)0x8C/0xFF blue:(CGFloat)0x8D/0xFF alpha:1]

#define LOG_TEXT_FIELD_X                    50.f
#define LOG_TEXT_FIELD_RIGHT_MARGIM         LOG_SEPERATOR_MARGIN

#define LOG_ICON_WIDTH                      50.f

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
    
    _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_bak.png"]];
    [self.view addSubview:_backgroundImageView];
    
    // log container
    _loginContainer = [[UIView alloc] init];
    [_loginContainer setFrame:CGRectMake(LOG_CONTAINER_X,
                                         LOG_CONTAINER_Y,
                                         (self.view.bounds.size.width - LOG_CONTAINER_X * 2 ),
                                         LOG_CONTAINER_H)];
    [_loginContainer setBackgroundColor:TS_COLOR_BKG];
    [self.view addSubview:_loginContainer];
    
    UIView *_seperator = [[UIView alloc] init];
    [_seperator setFrame:CGRectMake(LOG_SEPERATOR_MARGIN, _loginContainer.bounds.size.height * 0.5,
                                    _loginContainer.bounds.size.width - 2 * LOG_SEPERATOR_MARGIN,
                                    1)];
    [_seperator setBackgroundColor:LOG_SEPERATOR_COLOR];
    [_loginContainer addSubview:_seperator];
    
    UIImageView *_userIcon = [[UIImageView alloc] init];
    [_userIcon setImage:[UIImage imageNamed:@"login_username.png"]];
    [_userIcon setFrame:CGRectMake(0, 0,
                                   LOG_ICON_WIDTH,
                                   0.5 * _loginContainer.bounds.size.height)];
    [_userIcon setContentMode:UIViewContentModeCenter];
    [_loginContainer addSubview:_userIcon];
    
    UIImageView *_pwdIcon = [[UIImageView alloc] init];
    [_pwdIcon setFrame:CGRectMake(0, 0.5 * _loginContainer.bounds.size.height,
                                  LOG_ICON_WIDTH,
                                  0.5 * _loginContainer.bounds.size.height)];
    [_pwdIcon setImage:[UIImage imageNamed:@"login_password.png"]];
    [_pwdIcon setContentMode:UIViewContentModeCenter];
    [_loginContainer addSubview:_pwdIcon];
    
    _userNameTextField = [[UITextField alloc]
                          initWithFrame:CGRectMake(LOG_TEXT_FIELD_X,
                                                   0,
                                                   _loginContainer.bounds.size.width - LOG_TEXT_FIELD_X - LOG_TEXT_FIELD_RIGHT_MARGIM,
                                                   0.5 * _loginContainer.bounds.size.height)];
    _userNameTextField.font = [UIFont fontWithName:nil size:13];
    _userNameTextField.placeholder = @"输入手机号";
    _userNameTextField.delegate = self;
    [_loginContainer addSubview:_userNameTextField];
    
    CGRect _user_frame = _userNameTextField.frame;
    _user_frame.origin.y += 0.5 * _loginContainer.bounds.size.height;
    _passwordTextField = [[UITextField alloc] initWithFrame:_user_frame];
    _passwordTextField.font = [UIFont fontWithName:nil size:12];
    _passwordTextField.placeholder = @"输入密码";
    _passwordTextField.delegate = self;
    [_loginContainer addSubview:_passwordTextField];
    
    // register & forget pwd
    
    _registerButton = [[UIButton alloc] init];
    [_registerButton setFrame:CGRectMake(_loginContainer.frame.origin.x,
                                         _loginContainer.frame.origin.y + _loginContainer.bounds.size.height + 5,
                                         50,
                                         30)];
    [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_registerButton setTitle:@"马上注册" forState:UIControlStateNormal];
    [_registerButton.titleLabel setFont:[UIFont fontWithName:nil size:12]];
    [self.view addSubview:_registerButton];
    
    _forgetPwdButton = [[UIButton alloc] init];
    [_forgetPwdButton setFrame:CGRectMake(_loginContainer.frame.origin.x + _loginContainer.frame.size.width - 50,
                                          _loginContainer.frame.origin.y + _loginContainer.frame.size.height + 5,
                                          50,
                                          30)];
    [_forgetPwdButton.titleLabel setFont:[UIFont fontWithName:nil size:12]];
    [_forgetPwdButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_forgetPwdButton setTitle:@"找回密码" forState:UIControlStateNormal];
    [self.view addSubview:_forgetPwdButton];
    
    // login button 147 * 30
    
    _loginButton = [[UIButton alloc] init];
    [_loginButton setFrame:CGRectMake(0.5 * (self.view.bounds.size.width - 147),
                                      420,
                                      147,
                                      30)];
    [_loginButton setBackgroundImage:[UIImage imageNamed:@"loginbg.png"]
                            forState:UIControlStateNormal];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton.titleLabel setFont:[UIFont fontWithName:nil size:12]];
    [self.view addSubview:_loginButton];
    
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
    
    AFHTTPRequestOperation *_request = [[AFHTTPRequestOperation alloc]
                                        initWithRequest:[NSURLRequest requestWithURL:_url]];
    [_request setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"登录请求成功！请求链接：%@", _url);
        NSLog(@"%@", responseObject);
        NSData *_data = responseObject;
        char *_buffer = (char *)[_data bytes];
        NSString *_result = [NSString stringWithCString:_buffer encoding:NSStringEncodingConversionAllowLossy];
        if ( [_result isEqualToString:kTSLoginFailed] ) {
            NSLog(@"登录验证失败！");
        } else {
            NSLog(@"登录验证成功！");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"登录请求失败！请求链接：%@", _url);
    }];
    
    [_request start];
    return YES;
}

@end
