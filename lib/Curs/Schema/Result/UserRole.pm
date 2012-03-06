package Curs::Schema::Result::UserRole;
use parent 'DBIx::Class';

__PACKAGE__->load_components('Core');

__PACKAGE__->table( 'user_role' );
__PACKAGE__->add_columns(
    "user_id",
    { data_type => 'INT', default_value => 0, is_nullable => 0 },
    "role_id",
    { data_type => 'INT', default_value => 0, is_nullable => 0 },
);

__PACKAGE__->set_primary_key( 'user_id', 'role_id' );

__PACKAGE__->belongs_to( 'user', 'Curs::Schema::Result::User', { 'foreign.id' => 'self.role_id' });
__PACKAGE__->belongs_to( 'role', 'Curs::Schema::Result::Role', { 'foreign.id' => 'self.role_id' });

1;
