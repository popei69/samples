//
//  SongDisplay.h
//  ObjectiveCSample
//
//  Created by Benoit PASQUIER on 25/05/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Song;
@interface SongDisplay : NSObject

@property (nonatomic, readonly, nullable) NSString *title;
@property (nonatomic, readonly, nullable) NSString *subtitle;
@property (nonatomic, readonly, nullable) UIImage *coverImage;

- (instancetype)initWithSong:(nonnull Song*)song;

@end

NS_ASSUME_NONNULL_END
