# new
get '/sessions/new' => sub {
    template 'sessions/new';
};

# create
post '/sessions' => sub {
    my $user = resultset('User')->find({ email => lc param('session.email') });
    if ($user and $user->check_password(param('session.password'))) {
        sign_in $user;
        my $return_to = session->delete('return_to');
        redirect ($return_to || uri_for('/users/' . $user->id));
    } else {
        deferred 'danger' => 'Invalid email/password combination';
        template 'sessions/new';
    }
};

1;
