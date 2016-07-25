# Shopping_List
![ScreenShot](https://raw.github.com/James328/Shopping_List/master/screenshot.png)

AngularJS shopping list app - based off of http://lekkerlogic.com/2015/05/angularjs-and-bootstrap-mysql-shopping-list-tutorial/. Using this as a guide towards getting my feet wet with Angular.

## Installation
Requires PHP / MySQL, I'm using [MAMP](https://www.mamp.info/en/) to work locally but there are tons of other solutions for setting up an appropriate LAMP environment. Setup is almost as easy as installing Wordpress.
- Use shop.sql to setup your MySQL tables
- Update includes/db.php in order to connect to db
- Should be good to go after that!

## To Do List / Ideas
- [ ] User authentication
- [ ] Unit / build testing
- [ ] Indexing / relational system to help cache items previously entered, and store historical data about the item with the timestamps and prices
- [ ] Ability to create multiple shopping lists
- [ ] Add photos to item purchased (ability to use camera on mobile device, no clue how hard this would be)
- [X] ~~Be able to update the price by clicking / tapping, and indicate whether unit price or all together~~
- [X] ~~Function to calculate sum of prices for what has been entered in the shopping list~~
- [X] ~~Instead of tapping on the item in the shopping list to update status to complete, require that a price is entered in order to complete the item from the shopping list and move to the bottom of the list~~
- [X] ~~Add notes to items purchased~~