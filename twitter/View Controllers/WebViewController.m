//
//  WebViewController.m
//  twitter
//
//  Created by laurentsai on 7/1/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURLRequest *request=[NSURLRequest requestWithURL:self.link];
    [self.webView loadRequest:request ];//load the trailer in the webview
                   
    [self.webView reload];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
