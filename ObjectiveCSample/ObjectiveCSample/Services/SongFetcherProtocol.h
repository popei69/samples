//
//  SongFetcherProtocol.h
//  ObjectiveCSample
//
//  Created by Benoit PASQUIER on 23/05/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef SongFetcherProtocol_h
#define SongFetcherProtocol_h

#import "Song.h"

@protocol SongFetcherProtocol <NSObject>

- (void)fetchSongsWithSuccess:(void (^)(NSArray<Song *> *songs))successCompletion error:(void (^)(NSError *error))errorCompletion;

@end

@protocol SongParserProtocol <NSObject>

- (void)parseSongs:(NSData *)data withSuccess:(void (^)(NSArray<Song *> *songs))successCompletion error:(void (^)(NSError *error))errorCompletion;

@end


#endif /* SongFetcherProtocol_h */
