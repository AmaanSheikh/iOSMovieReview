//
//  RootTableViewController.h
//  tmdbMovie
//
//  Created by Rafay on 11/8/16.
//  Copyright © 2016 AstuteSol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connector.h"

@interface RootTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource,NSURLConnectionDataDelegate>
{
    NSString *movieID;
    NSString *movieName;
    NSString *posterPath;
    NSNumber *vote;
    NSString *description;
}

@property(strong,nonatomic)Connector *connectorClass;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
