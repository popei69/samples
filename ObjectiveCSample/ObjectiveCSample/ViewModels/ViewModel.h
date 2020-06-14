//
//  ViewModel.h
//  ObjectiveCSample
//
//  Created by Benoit PASQUIER on 23/05/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SongDisplay.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewModel : NSObject


- (void)getSongsWithSuccess:(void (^)(NSArray<SongDisplay*> *displays))successCompletion error:(void (^)(NSError *error))errorCompletion;

- (NSUInteger)numberOfItems;
- (NSUInteger)numberOfSections;
- (nullable SongDisplay *)itemAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
