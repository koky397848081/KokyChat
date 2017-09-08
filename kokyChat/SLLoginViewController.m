//
//  SLLoginViewController.m
//  SmartLi
//


#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#import "SLLoginViewController.h"

@interface SLLoginViewController ()<EaseMessageViewControllerDataSource,EaseMessageViewControllerDelegate>
{
    __weak IBOutlet UIView *_toolBarView;
    
    __weak IBOutlet UITextField *_textfield;
    
    __weak IBOutlet UIButton *_getMessageBtn;
    BOOL _isSender;

}
@end

@implementation SLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataSource = self;
    self.delegate = self;
    _isSender = YES;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    self.chatToolbar.hidden = YES;
    
    [self setChatToolbar:_toolBarView];
    [_textfield becomeFirstResponder];
    [[EaseBaseMessageCell appearance] messageNameIsHidden];
    [[EaseBaseMessageCell appearance] setAvatarSize:0.f];

    UIBarButtonItem* rightBtnItem = [[UIBarButtonItem alloc]initWithTitle:@"getMessage" style:UIBarButtonItemStylePlain target:self action:@selector(getMessageButtonClick:) ];
    self.navigationItem.rightBarButtonItem =rightBtnItem;
    
    [self.view bringSubviewToFront:_toolBarView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)sendButtonClick:(id)sender {
   
    EMMessage *message =  [EaseSDKHelper sendTextMessage:_textfield.text to:@"self.conversation.chatter" messageType:EMChatTypeChat messageExt:nil];
    [self addMessageToDataSource:message
                        progress:nil];
    
    [self scrollToBottom];
    
}

- (IBAction)cancelButtonClick:(id)sender {
   // [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getMessageButtonClick:(id)sender {
    EMMessage *message =  [EaseSDKHelper sendTextMessage:@"你好呀～你可以问我问题～我会卖萌" to:[[EMClient sharedClient] currentUsername] messageType:EMChatTypeChat messageExt:nil];
    _isSender = NO;
    [self addMessageToDataSource:message
                        progress:nil];
   
    [self scrollToBottom];

}

- (void)textChanged:(NSNotification * )notification
{
    int MAX_PHONE_LEGNTH = 11;
    UITextField *textfield = (UITextField *)notification.object;
    if (textfield.text.length > MAX_PHONE_LEGNTH) {
        textfield.text = [textfield.text substringToIndex:MAX_PHONE_LEGNTH];
    }
}

#pragma mark
#pragma mark keyboard
- (void)keyBoardWillChangeFrame:(NSNotification*)notification{
    
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    if (frame.origin.y >= SCREEN_HEIGHT - 44 ) { // 没有弹出键盘
        
        //收起键盘
        [UIView animateWithDuration:duration animations:^{
            _toolBarView.transform =  CGAffineTransformIdentity;
            self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64  - 44);

        }];
        
    }else{
        // 弹出键盘
        [UIView animateWithDuration:duration animations:^{
            _toolBarView.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
            self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - frame.size.height - 44);
            [self scrollToBottom];
        }];
    }
}

-(void)scrollToBottom {
    
    if(self.dataArray.count == 0){
        
        return;
    }

    NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:lastIndex atScrollPosition:UITableViewScrollPositionBottom animated:YES];

}

#pragma mark - EaseMessageViewControllerDataSource
- (id<IMessageModel>)messageViewController:(EaseMessageViewController *)viewController
                           modelForMessage:(EMMessage *)message
{
    
      id<IMessageModel> model = nil;
    model = [[EaseMessageModel alloc] initWithMessage:message];
    model.isSender = _isSender;
    _isSender = YES;
    return model;
}

@end
