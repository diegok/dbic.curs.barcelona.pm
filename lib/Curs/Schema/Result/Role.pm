package Curs::Schema::Result::Role;
use strict;
use warnings;
use parent qw( DBIx::Class );
use utf8;

__PACKAGE__->load_components('Core');
__PACKAGE__->table( 'role' );

__PACKAGE__->add_columns(
    'id',
    { data_type => 'INT', is_nullable => 0, is_auto_increment => 1 },
    'name',
    { data_type => 'VARCHAR', default_value => "", is_nullable => 0, size => 20 },
);

__PACKAGE__->set_primary_key( 'id' );
__PACKAGE__->add_unique_constraint( 'name', ['name'] );
__PACKAGE__->has_many( 'user_roles', 'Curs::Schema::Result::UserRole', { 'foreign.role_id' => 'self.id' } );
__PACKAGE__->many_to_many( 'users', 'user_roles', 'user' );

1;
