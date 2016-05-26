//
//  LoginViewController.m
//  ToDoCoreData
//
//  Created by Jayesh Wadhwani on 2016-05-25.
//  Copyright © 2016 Jayesh Wadhwani. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // [[UIView appearance] setBackgroundColor:[UIColor redColor]];

//    [self.view setBackgroundColor:[UIColor clearColor]];

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

- (IBAction)actionOnLogin:(id)sender {

   
    
    [self performSegueWithIdentifier:@"table" sender:self];

}

@end
