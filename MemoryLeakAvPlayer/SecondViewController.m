//
//  SecondViewController.m
//  MemoryLeakAvPlayer
//
//  Created by Jorge Ferro on 30/08/16.
//  Copyright © 2016 IT. All rights reserved.
//

#import "SecondViewController.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface SecondViewController ()

@property (strong, nonatomic) AVPlayerViewController *playerController;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)botaoAssistirVideo:(id)sender {
    NSString *video = [NSString stringWithFormat:@"%@",@"http://www.irontrainersfitness.com/TricepsNoCaboComCorda/masterPlaylist.m3u8" ];
        
    NSURL *url = [NSURL URLWithString:video];
    
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:url];

    AVPlayer *player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
    
    self.playerController = [[AVPlayerViewController alloc] init];
    self.playerController.player = player;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[player currentItem]];
    
    [self.playerController.player addObserver:self forKeyPath:@"status" options:0 context:nil];
    
    [self presentViewController:self.playerController animated:YES completion:nil];
    
}

-(void)dealloc {
    [self.playerController removeFromParentViewController];
    self.playerController = nil;
    //self.playerController = nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    NSLog(@"observer removed");
    
    if (object == self.playerController.player && [keyPath isEqualToString:@"status"]) {
        if (self.playerController.player.status == AVPlayerStatusFailed) {
            NSLog(@"AVPlayer Failed");
            
        } else if (self.playerController.player.status == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
            [self.playerController.player play];
            
            
        } else if (self.playerController.player.status == AVPlayerItemStatusUnknown) {
            NSLog(@"AVPlayer Unknown");
            
        }
        NSLog(@"is this code running?");
        [self.playerController.player removeObserver:self forKeyPath:@"status"];
    }
}
//
//
//
- (void)playerItemDidReachEnd:(NSNotification *)notification {
    
    NSLog(@"playback finished");
    
    
    //  code here to play next sound file
    
}

@end
