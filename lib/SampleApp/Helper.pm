package SampleApp::Helper;
use Dancer2::Plugin;

register current_user => sub {
    my $dsl = shift;
    if ($dsl->session('user_id')) {
        $dsl->vars->{current_user} ||= $dsl->resultset('User')->find($dsl->session('user_id'));
    }
    return $dsl->vars->{current_user};
};

on_plugin_import {
    my $dsl = shift;
    $dsl->hook(before_template_render => sub {
        my $tokens = shift;
        $tokens->{current_user} = sub { $dsl->current_user };
    });
};

register sign_out => sub {
    my $dsl = shift;
    $dsl->app->destroy_session;
};

register sign_in => sub {
    my $dsl = shift;
    my $user = shift;
    $dsl->session(user_id => $user->id);
};

register require_sign_in => sub {
    my $dsl = shift;
    my $route_sub = shift;

    return sub {
        unless ($dsl->current_user) {
            $dsl->session(return_to => $dsl->request->uri_base . $dsl->request->uri) if $dsl->request->is_get;
            $dsl->deferred(info => 'Please sign in.');
            return $dsl->redirect($dsl->uri_for('/signin'));
        }
        return $route_sub->($dsl);
    };
};

register_plugin;

1;
