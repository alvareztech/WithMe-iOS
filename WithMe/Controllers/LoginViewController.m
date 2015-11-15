//
//  LoginViewController.m
//  WithMe
//
//  Created by Daniel Alvarez on 14/11/15.
//  Copyright © 2015 Daniel Alvarez. All rights reserved.
//

#import "LoginViewController.h"



@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    
//    DGTAuthenticateButton *authButton;
//    authButton = [DGTAuthenticateButton buttonWithAuthenticationCompletion:^(DGTSession *session, NSError *error) {
//        if (session.userID) {
//            // TODO: associate the session userID with your user model
//            NSString *msg = [NSString stringWithFormat:@"Phone number: %@", session.phoneNumber];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You are logged in!"
//                                                            message:msg
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles:nil];
//            [alert show];
//        } else if (error) {
//            NSLog(@"Authentication error: %@", error.localizedDescription);
//        }
//    }];
//    authButton.center = self.view.center;
//    authButton.digitsAppearance = [self makeTheme];
//
//    [self.view addSubview:authButton];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (DGTAppearance *)makeTheme {
    DGTAppearance *theme = [[DGTAppearance alloc] init];
//    theme.bodyFont = [UIFont fontWithName:@"Noteworthy-Light" size:16];
//    theme.labelFont = [UIFont fontWithName:@"Noteworthy-Bold" size:17];
    theme.accentColor = [UIColor primaryColor];
    theme.backgroundColor = [UIColor colorWithRed:(240.0/255.0) green:(255/255.0) blue:(250/255.0) alpha:1];
    // TODO: Set a UIImage as a logo with theme.logoImage
    return theme;
}


- (IBAction)signIn:(UIButton *)sender {
    Digits *digits = [Digits sharedInstance];
    
    DGTAuthenticationConfiguration *configuration = [[DGTAuthenticationConfiguration alloc] initWithAccountFields:DGTAccountFieldsDefaultOptionMask];
    configuration.phoneNumber = @"+591";
    configuration.appearance = [self makeTheme];

    [digits authenticateWithViewController:nil configuration:configuration completion:^(DGTSession *session, NSError *error) {
        if (!error) {
            [PFUser loginWithDigitsInBackground:^(PFUser *user, NSError *error) {
                if(!error){
                    // do something with user
                    NSLog(@"START CREDENTIALS");
                    PFUser *user = [PFUser currentUser];
                    NSLog(@"Parse User: %@ %@ %@", user.username, user.password, user[@"phone"]);
                    DGTSession *session = [[Digits sharedInstance] session];
                    NSLog(@"Digits Session: %@ %@ %@", session.authToken, session.authTokenSecret, session.phoneNumber);
                    NSLog(@"END CREDENTIALS");
                    
                    UITabBarController *mainTabBarController = [self.storyboard instantiateViewControllerWithIdentifier:@"mainTabBarController"];
                    [self presentViewController:mainTabBarController animated:YES completion:nil];
                    
                } else {
                    NSLog(@"Parse Error %@", error);
                }
            }];
        } else {
            NSLog(@"Digits Error %@", error);
        }
    }];
    
}

@end
