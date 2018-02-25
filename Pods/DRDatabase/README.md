DRDatabase
==========
DRDatabase connects your app with your MySQL database. Enter SQL commands to get the information you want. DRDatabase gives you your results in a Dictionary, so you can easily use it.

Usage
-----
First of all you need to upload [DRDatabase.php](https://github.com/danielriege/DRDatabase/blob/master/DRDatabase.php) to your webserver where the MySQL server is running or you upload it to a different webserver but then you need to configure a remote access from the webserver to the MySQL server.

###Xcode project
Add ```import DRDatabase``` at the top of every file you want to make a MySQL Query.

First start by setting up your connection to a database.
```swift
let phpFile: URL! = URL(string: "URL_WHERE_PHP_FILE_IS LOCATED") // e.g. http://213.123.456.567/DRDatabase.php
let host: URL! = URL(string: "localhost") // If your database is on the same server as the php file,
                                                  //use 'localhost' , otherwise use the ip address of
                                                  //your database and configure remote access.
let databaseName = "DATABASE_NAME" // name of your MySQL database
let username = "USERNAME"
let password = "PASSWORD"

let connection = DRConnection(host: host, database: databaseName, username: username, password: password)
let database = DRDatabase(phpFileUrl: phpFile, connection: connection)
```
Now you can start with a first SQL Query.
```swift
let userName = "Test Name"
// Use normal SQL syntax
let command = String(format: "SELECT * FROM test WHERE name = %@", userName)

// execute your command
database.execute(sqlCommand: command) { (detailedJsonObject, error) in
    if let error = error {
        // some error handling
        print("\(error.errorCode!): \(error.errorDescription!)") // Includes URLRequest errors and MySQL syntax/server errors
    }
    if let jsonObject = detailedJsonObject {
        if jsonObject.result?.isEmpty == false {
            // jsonObject.result! is your data from the database in a [[String:Any]] format
            print(jsonObject.result! as Any)
        } else {
            // This happens at a INSERT, UPDATE or DELETE command.
            print("There is no JSON! Command successfully sent and executed by database")
        }
    }
}

// cancel a running request
database.abortExecution()
```

Installation
------------
###CocoaPods
If you use CocoaPods to manage your dependencies, simply add Attributed to your ```Podfile```:
```
pod 'DRDatabase'
```


License
-------
DRDatabase is released under the [MIT License](https://github.com/danielriege/DRDatabase/blob/master/LICENSE).
