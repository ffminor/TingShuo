//
//  TSLoginViewController.m
//  TingShuo
//
//  Created by fminor on 8/31/14.
//
//

#import "TSLoginViewController.h"
#import "AFNetworking.h"

NSString *TSLoginServerUrl = @"http://42.121.144.167/?type=reg&acc=123&pwd=456";
NSString *TSRegisterServerUrl = @"http://42.121.144.167/?type=logon&name=123&pwd=456";

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
    [self.view addSubview:_userNameTextField];
    
    CGRect _user_frame = _userNameTextField.frame;
    _user_frame.origin.y += 43;
    _passwordTextField = [[UITextField alloc] initWithFrame:_user_frame];
    [_passwordTextField.layer setBorderWidth:1.0f];
    [_passwordTextField.layer setBorderColor:[UIColor blackColor].CGColor];
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

@end
