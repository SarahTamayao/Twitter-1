//
//  ComposeViewController.m
//  twitter
//
//  Created by laurentsai on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()<UITextViewDelegate>

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tweetTextView.delegate=self;
    [self.tweetTextView setClearsOnInsertion:YES];
}
- (IBAction)sendTweet:(id)sender {
    [[APIManager shared] postStatusWithText:self.tweetTextView.text completion:^(Tweet *senttweet, NSError * error) {
        if (senttweet) {
            NSLog(@"Successfully posted the tweet");
            [self.delegate didTweet:senttweet];
        } else {
            NSLog(@"😫😫😫 Error posting tweet: %@", error.localizedDescription);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}


- (IBAction)closeTweet:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    // TODO: Check the proposed new text character count
   // Allow or disallow the new text
    int charLimit=280;
    //see if user is allowed to add the new text
    NSString *newText= [self.tweetTextView.text stringByReplacingCharactersInRange:range withString:text];
    return newText.length < charLimit;
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
