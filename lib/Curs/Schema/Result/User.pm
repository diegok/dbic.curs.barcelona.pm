package Curs::Schema::Result::User;
use strict;
use warnings;

use parent qw( DBIx::Class );
use utf8;

__PACKAGE__->load_components(qw/ EncodedColumn Core /);

__PACKAGE__->table( 'user' );
__PACKAGE__->add_columns(
    'id',
    { data_type => 'INT', is_nullable => 0, is_auto_increment => 1 },
    'email',
    { data_type => 'VARCHAR', default_value => "", is_nullable => 0, size => 255 },
    'password',
    {
        data_type           => 'VARCHAR',
        default_value       => '',
        is_nullable         => 0,
        size                => 40 + 10,
        encode_column       => 1,
        encode_class        => 'Digest',
        encode_args         => { algorithm => 'SHA-1', format => 'hex', salt_length => 10 },
        encode_check_method => 'check_password', 
    },
    'name',
    {
        data_type => 'VARCHAR',
        default_value => "",
        is_nullable => 1,
        size => 64,
    },
);

__PACKAGE__->set_primary_key( 'id' );
__PACKAGE__->add_unique_constraint( 'email', ['email'] );

__PACKAGE__->has_many( 'user_roles', 'Curs::Schema::Result::UserRole', { 'foreign.user_id' => 'self.id' } );
__PACKAGE__->many_to_many( 'roles', 'user_roles', 'role' );

__PACKAGE__->has_many( 'events', 'Curs::Schema::Result::Event', { 'foreign.creator_id' => 'self.id' } );

__PACKAGE__->has_many( 'rel_assists', 'Curs::Schema::Result::EventUser', { 'foreign.user_id' => 'self.id' }, { cascade_delete => 1 });
__PACKAGE__->many_to_many( 'assists', 'rel_assists', 'event' );

=head2 update_roles
 Set the user's roles
 Arguments: list of role names ('admin', 'editor', etc)
=cut
sub update_roles {
    my( $self, @roles ) = @_;

    my $rs = $self->result_source->schema->resultset('Role');
    my %roles = map { $_ => 1 } @roles;

    my @objs;
    if (keys %roles) {
        @objs = $rs->search({ name => { 'IN' , [ keys %roles ] } });
    }
    $self->set_roles( \@objs );
    return 1;   # true value so we can test for success
}

1;
