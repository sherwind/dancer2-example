# index 
get '/users' => require_sign_in sub {
    my @users = resultset('User')->all;
    template 'users/index' => { users => \@users };
};

# new
get '/users/new' => sub {
    my $user = resultset('User')->new_result({});

    my $form = SampleApp::Form::User->new;
    $form->process(item => $user, params => { params });

    template 'users/new' => { form => $form };
};

# show
get '/users/:id' => require_sign_in sub {
    my $user = resultset('User')->find(param('id'))
        or return send_error('Not Found', 404);

    template 'users/show' => { user => $user };
};

# edit
get '/users/:id/edit' => require_sign_in sub {
    my $user = resultset('User')->find(param('id'))
        or return send_error('Not Found', 404);

    my $form = SampleApp::Form::User->new;
    $form->process(item => $user, params => { params });

    template 'users/edit' => { form => $form };
};

# create
post '/users' => sub {
    my $user = resultset('User')->new_result({});

    my $form = SampleApp::Form::User->new;
    $form->process(item => $user, params => { params });

    if ($form->validated) {
        sign_in $user;
        deferred success => 'Welcome to the Sample App!';
        redirect uri_for('/users/' . $user->id);
    } else {
        template 'users/new' => { form => $form };
    }
};

# update
any [ 'post', 'put' ] => '/users/:id' => require_sign_in sub {
    my $user = resultset('User')->find(param('id'))
        or return send_error('Not Found', 404);

    my $form = SampleApp::Form::User->new;
    $form->process(item => $user, params => { params });

    if ($form->validated) {
        deferred success => 'Profile Updated';
        redirect uri_for('/users/' . $user->id);
    } else {
        template 'users/edit' => { form => $form };
    }
};

1;
