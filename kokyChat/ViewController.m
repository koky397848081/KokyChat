//
//  ViewController.m


#import "ViewController.h"
#import "EaseUI.h"
#import "SLLoginViewController.h"
#import "SLChatViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)loginButtonClicked:(id)sender {
  //  [self presentViewController:[[SLLoginViewController alloc]init] animated:YES completion:nil];
    [self.navigationController pushViewController:[[SLLoginViewController alloc]init] animated:YES];

}

- (IBAction)pushChatViewController:(id)sender {
    SLChatViewController *chatController = [[SLChatViewController alloc] initWithConversationChatter:@"SmartLi" conversationType:EMConversationTypeChat];
    [self.navigationController pushViewController:chatController animated:YES];
}

@end
