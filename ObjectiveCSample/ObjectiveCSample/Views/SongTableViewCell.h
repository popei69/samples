//
//  SongTableViewCell.h
//  ObjectiveCSample
//
//  Created by Benoit PASQUIER on 23/05/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Song;
@interface SongTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel * titleLabel;
@property (nonatomic, strong) IBOutlet UILabel * artistLabel;
@property (nonatomic, strong) IBOutlet UIImageView * coverImageView;

- (void)setDisplay:(nullable Song*)song;

@end

NS_ASSUME_NONNULL_END
