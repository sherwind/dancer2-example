package SampleApp::Schema::Result::User;

use strict;
use warnings;

use parent qw(SampleApp::Schema::Result);

__PACKAGE__->load_components(qw(PassphraseColumn));

__PACKAGE__->table('users');
__PACKAGE__->add_columns(qw(
    id
    name
    email
    created_at
    updated_at
));
__PACKAGE__->add_column(
    password_digest => {
        passphrase => 'crypt',
        passphrase_class => 'BlowfishCrypt',
        passphrase_args  => { key_nul => 1, cost => 10, salt_random => 1 },
        passphrase_check_method => 'check_password',
    }
);
__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint([ qw(email) ]);

1;
