//
//  dataApi.h
//  tmdbMovie
//
//  Created by Rafay on 11/8/16.
//  Copyright © 2016 AstuteSol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dataApi : NSObject
{
    NSString *title;
    NSString *description;
}
@property (nonatomic) NSString *title;
@property(nonatomic)NSString *description;
@property(nonatomic)NSNumber *id;
@property (nonatomic)NSString *posterPath;
@property(nonatomic)NSNumber *vote;
//----actor--//
@property(nonatomic)NSString *actorName;
@property(nonatomic)NSString *charchter;
@property(nonatomic)NSString *profilePath;
@property(nonatomic)NSNumber *actorId;


@end

