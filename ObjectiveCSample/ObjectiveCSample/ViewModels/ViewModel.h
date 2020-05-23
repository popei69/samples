//
//  ViewModel.h
//  ObjectiveCSample
//
//  Created by Benoit PASQUIER on 23/05/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Song.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewModel : NSObject


- (void)getSongsWithSuccess:(void (^)(NSArray<Song*> *songs))successCompletion error:(void (^)(NSError *error))errorCompletion;

- (NSUInteger)numberOfItems;
- (NSUInteger)numberOfSections;
- (nullable Song *)itemAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
