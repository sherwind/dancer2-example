package SampleApp::Schema::Result;

use strict;
use warnings;

use parent qw(DBIx::Class::Core);

sub insert {
    my $self = shift;

    $self->set_column(created_at => \'CURRENT_TIMESTAMP') 
        if $self->result_source->has_column('created_at');

    return $self->next::method(@_);
}

sub update {
    my $self = shift;

    $self->set_column(updated_at => \'CURRENT_TIMESTAMP')
        if $self->result_source->has_column('updated_at');

    return $self->next::method(@_);
}

1;
