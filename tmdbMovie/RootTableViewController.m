//
//  RootTableViewController.m
//  tmdbMovie
//
//  Created by Rafay on 11/8/16.
//  Copyright © 2016 AstuteSol. All rights reserved.
//

#import "RootTableViewController.h"
#import "dataApi.h"
#import "SecondTableViewController.h"
#import "Connector.h"

@interface RootTableViewController (){
   
}

@end

@implementation RootTableViewController
{
    NSMutableData *webData;
    NSMutableArray *array;
    NSMutableArray *arrayId;
    NSURLConnection *connection;
    UITableViewCell *selectedCell;
    NSUInteger lastIndex;
  
   
   
}

- (void) viewWillAppear:(BOOL)animated
{
   // [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self tableView]setDelegate:self ];
    [[self tableView]setDataSource:self];
    array=[[NSMutableArray alloc]init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


//---------API---------//
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    [webData setLength:0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [webData appendData:data];
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"Fail With Error");
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
  
    NSDictionary *allData=[NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];
    NSArray *array1 = [[NSArray alloc]initWithArray:[allData objectForKey:@"results"]];
    
    
    
    for (NSDictionary *diction in array1)
    {
      
        dataApi *api = [[dataApi alloc]init];
        api.title=[diction objectForKey:@"title"];
        api.description=[diction objectForKey:@"overview"];
        api.id=[diction objectForKey:@"id"];
        api.posterPath=[diction objectForKey:@"poster_path"];
        api.vote=[diction objectForKey:@"vote_average"];
        [array addObject:api];
        
    }
    
    [[self tableView ]reloadData];
    
}
//-----Search-----///


-(void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    //This'll Show The cancelButton with Animation
    [searchBar setShowsCancelButton:YES animated:YES];
    //remaining Code'll go here
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
    
    [searchBar setShowsCancelButton:NO animated:YES];
    [array removeAllObjects];
    [self.tableView reloadData];
    searchBar.text=@"";
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [array removeAllObjects];
    
    NSString *movieName=searchBar.text;
    NSString *movieString = [NSString stringWithFormat:@"https://api.themoviedb.org/3/search/movie?query=%@&api_key=c4bd81709e87b12e6c74a08609433c49",movieName];
    NSString *finalString=[movieString stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    NSURL *url=[NSURL URLWithString:finalString];
    
    
    
    
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    connection=[NSURLConnection connectionWithRequest:request delegate:self];
    if (connection)
    {
        webData=  [[NSMutableData alloc]init];
    }
         [searchBar resignFirstResponder];
}
//-----------------//

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-------tableView---//

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [array count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    dataApi *current = [array objectAtIndex:indexPath.row];
    cell.textLabel.text = [current title];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //selectedcelltext
    NSIndexPath *path=[tableView indexPathForSelectedRow];
    
    
    lastIndex = [path indexAtPosition:[path length] - 1];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    dataApi *aBook = [array objectAtIndex:lastIndex];
    movieID=aBook.id;
    movieName=aBook.title;
    posterPath=aBook.posterPath;
    description=aBook.description;
    vote=aBook.vote;
    
    [self performSegueWithIdentifier:@"showDetails" sender:self];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showDetails"]) {
        SecondTableViewController *vc=segue.destinationViewController;
        Connector *connectorClass=[[Connector alloc]init];
        connectorClass.IdBeingPassed=movieID;
        connectorClass.movieNameBeingPassed=movieName;
        connectorClass.posterPathBeingPassed=posterPath;
        connectorClass.voteBeingPassed=vote;
        connectorClass.desBeingPassed=description;
        vc.connectorClass=connectorClass;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
