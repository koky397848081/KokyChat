//
//  SLChatViewController.m


#import "SLChatViewController.h"
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface SLChatViewController ()<EaseMessageViewControllerDelegate,EaseMessageViewControllerDataSource>

{
    EaseMessageModel *_model;
    BOOL _isSender;

}
@end

@implementation SLChatViewController


- (id)initWithConversationChatter:(NSString *)conversationChatter conversationType:(EMConversationType)conversationType
{
    self = [super initWithConversationChatter:conversationChatter conversationType:conversationType];
    self.delegate = self;
    self.dataSource = self;
    self.title = conversationChatter;
    _isSender = YES;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
      UIBarButtonItem* rightBtnItem = [[UIBarButtonItem alloc]initWithTitle:@"changeSender" style:UIBarButtonItemStylePlain target:self action:@selector(getMessageButtonClick:) ];
    self.navigationItem.rightBarButtonItem =rightBtnItem;
    
}

- (void)interfaceEaseUIConfig{
    /*
     [[EaseBaseMessageCell appearance] setSendBubbleBackgroundImage:[[UIImage imageNamed:@"EaseUIResource.bundle/chat_sender_bg"] stretchableImageWithLeftCapWidth:5 topCapHeight:35]];
     [[EaseBaseMessageCell appearance] setRecvBubbleBackgroundImage:[[UIImage imageNamed:@"EaseUIResource.bundle/chat_receiver_bg"] stretchableImageWithLeftCapWidth:35 topCapHeight:35]];
     
     [[EaseBaseMessageCell appearance] setSendMessageVoiceAnimationImages:@[[UIImage imageNamed:@"chat_sender_audio_playing_full"], [UIImage imageNamed:@"chat_sender_audio_playing_000"], [UIImage imageNamed:@"chat_sender_audio_playing_001"], [UIImage imageNamed:@"chat_sender_audio_playing_002"], [UIImage imageNamed:@"chat_sender_audio_playing_003"]]];
     
     [[EaseBaseMessageCell appearance] setRecvMessageVoiceAnimationImages:@[[UIImage imageNamed:@"chat_receiver_audio_playing_full"],[UIImage imageNamed:@"chat_receiver_audio_playing000"], [UIImage imageNamed:@"chat_receiver_audio_playing001"], [UIImage imageNamed:@"chat_receiver_audio_playing002"], [UIImage imageNamed:@"chat_receiver_audio_playing003"]]];
     
     
     [[EaseBaseMessageCell appearance] setAvatarSize:40.f];
     
     [[EaseBaseMessageCell appearance] setAvatarCornerRadius:20.f];
     
     [[EaseChatBarMoreView appearance] setMoreViewBackgroundColor:[UIColor colorWithRed:240 / 255.0 green:242 / 255.0 blue:247 / 255.0 alpha:1.0]];
     
     
     [self tableViewDidTriggerHeaderRefresh];
     
     EaseEmotionManager *manager= [[EaseEmotionManager alloc] initWithType:EMEmotionDefault emotionRow:3 emotionCol:7
     emotions:[EaseEmoji allEmoji]];
     [self.faceView setEmotionManagers:@[manager]];
     */
    //删除视频接口
    //    [self.chatBarMoreView removeItematIndex:3]; //电话
    //    [self.chatBarMoreView removeItematIndex:3]; //视频
    
    [[EaseBaseMessageCell appearance] messageNameIsHidden];
    [[EaseBaseMessageCell appearance] setAvatarSize:0.f];

}

- (void)getMessageButtonClick:(id)sender {
    _isSender = !_isSender;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - EaseMessageViewControllerDelegate

- (void)messageViewController:(EaseMessageViewController *)viewController
  didSelectAvatarMessageModel:(id<IMessageModel>)messageModel
{
    
}

#pragma mark - EaseMessageViewControllerDataSource
- (id<IMessageModel>)messageViewController:(EaseMessageViewController *)viewController
                           modelForMessage:(EMMessage *)message
{
    
  //  id<IMessageModel> model = nil;
    _model = [[EaseMessageModel alloc] initWithMessage:message];
    _model.isSender = _isSender;
//    if( _model.isSender)
//    {
//        _model.avatarImage = [UIImage imageNamed:@"me"];
//        _model.nickname = @"me";
//    }
//    else
//    {
//        _model.avatarImage = [UIImage imageNamed:@"receive"];
//  //      _model.nickname = @"SmartLi";
//    }
//    
//    _model.failImageName = @"imageDownloadFail";
    return _model;
}

@end
