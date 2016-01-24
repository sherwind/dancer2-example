package SampleApp;
use Dancer2;
use Dancer2::Plugin::Deferred;
use Dancer2::Plugin::DBIC qw(schema resultset);

use SampleApp::Form::User;
use SampleApp::Helper;

# N.B. we cannot split into multiple "use"-able packages yet because of https://github.com/PerlDancer/Dancer2/issues/888
require SampleApp::Controller::Sessions;
require SampleApp::Controller::Users;

our $VERSION = '0.1';

get '/' => sub {
    template 'static_pages/home';
};

get '/signup' => sub {
    forward '/users/new';
};

get '/signin' => sub {
    forward '/sessions/new';
};

any [ 'get', 'delete' ] => '/signout' => sub {
    sign_out;
    redirect uri_for('/');
};

1;
