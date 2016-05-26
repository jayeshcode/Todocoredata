//
//  DefaultViewController.m
//  ToDoCoreData
//
//  Created by Jayesh Wadhwani on 2016-05-25.
//  Copyright © 2016 Jayesh Wadhwani. All rights reserved.
//

#import "DefaultViewController.h"

@interface DefaultViewController ()

@property (weak, nonatomic) IBOutlet UITextField *deafaulttext1;
@property (weak, nonatomic) IBOutlet UITextField *defaulttext2;


@end

@implementation DefaultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)actionSave:(id)sender {
    
    NSUserDefaults *prefs =[NSUserDefaults standardUserDefaults];
     [prefs setObject:self.deafaulttext1.text forKey:@"defaulttitle"];
    [prefs setObject:self.defaulttext2.text forKey:@"defauldescript"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    


}
@end
