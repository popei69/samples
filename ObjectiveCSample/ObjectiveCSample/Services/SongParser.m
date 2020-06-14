//
//  SongParser.m
//  ObjectiveCSample
//
//  Created by Benoit PASQUIER on 23/05/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

#import "SongParser.h"

@implementation SongParser

- (void)parseSongs:(NSData *)data withSuccess:(void (^)(NSArray<Song *> *))successCompletion error:(void (^)(NSError *))errorCompletion {
    
    NSError *error;
    NSDictionary * jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if (!jsonDictionary || error) {
        // TODO: handle error better way
        errorCompletion(error);
        return;
    }
    
    NSArray *jsonArray = [jsonDictionary objectForKey:@"result"];
    if (!jsonArray) {
        // TODO: handle error
        NSError * error = [NSError errorWithDomain:NSCocoaErrorDomain code:999 userInfo:nil];
        errorCompletion(error);
        return;
    }
    
    NSMutableArray<Song *> *result = [[NSMutableArray alloc] init];
    for (NSDictionary *item in jsonArray) {
        
        // TODO: test fields
        NSString *title = [item objectForKey:@"title"];
        NSString *artistName = [item objectForKey:@"artist_name"];
        NSString *albumCover = [item objectForKey:@"cover"];
        
        Song * song = [[Song alloc] initWithTitle:title artistName:artistName albumCover:albumCover];
        [result addObject:song];
    }
    
    successCompletion(result);
}

@end
