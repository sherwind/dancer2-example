package SampleApp::Form::User;
use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';

has '+name'        => (default => 'user');
has '+html_prefix' => (default => 1);

has_field 'name'  => (type => 'Text', required => 1, maxlength => 50);
has_field 'email' => (
    type     => 'Email', 
    required => 1, 
    apply    => [ { transform => sub { lc $_[0] } } ]
);
has_field 'password' => (type => 'Password', required => 1, minlength => 6, noupdate => 1);
has_field 'password_confirmation' => (type => 'PasswordConf', required => 1, noupdate => 1);

before 'update_model' => sub {
    my $self = shift;

    $self->item->password_digest($self->field('password')->value);
};

# If element id is "foo.bar" the jQuery selector would have to written as "$('#foo\\.bar')", 
# so do not use dot as separator!
sub build_update_subfields {
    { all => { build_id_method => \&custom_id } }
}
sub custom_id {
    my $self = shift;
    my $prefix = ($self->form && $self->form->html_prefix) ? $self->form->name . '.' : '';
    my $full_name = $prefix . $self->full_name;
    $full_name =~ s/\./_/g;
    return $full_name;
}

__PACKAGE__->meta->make_immutable;
no HTML::FormHandler::Moose;

1;
