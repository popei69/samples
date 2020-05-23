//
//  Song.h
//  ObjectiveCSample
//
//  Created by Benoit PASQUIER on 23/05/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Song : NSObject

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * artistName;
@property (nonatomic, strong) NSString * albumCover;

- (instancetype)initWithTitle:(NSString*)title artistName:(NSString*)artistName albumCover:(NSString*)albumCover;

- (nullable NSURL*)albumCoverUrl;

@end

NS_ASSUME_NONNULL_END
