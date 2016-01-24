Dancer2 Simple Example
======================

This is an example of a simple [Dancer2](http://perldancer.org/) application, inspired by [railstutorial](https://github.com/railstutorial/sample_app), that makes use of the following technology: 

* SQLite - file-based relational database engine
* Carton - Perl module dependency manager
* DBIx::Class - database object relational mapper (ORM)
* DBIx::Class::PassphraseColumn - automatically hash password column
* Template::Toolkit - template processing system
* HTML::FormHandler - HTML form handling
* Dancer2::Plugin::Deferred - flash message for Dancer2
* Dancer2::Session::Simple - in-memory session backend for Dancer2 (for testing only)

Running the application locally
--------------------------------

To run it locally, just cd into the dancer2-example directory and run the following commands:

```
carton install
carton exec plackup bin/app.psgi
```

TODO
----

* Add Ajax-aware Cross Site Request Forgery (CSRF) protection
* Try Template::Alloy or Text::Xslate
* Dockerize the application
