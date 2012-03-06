package Curs::Schema::Result::EventUser;
use strict; use warnings;
use parent qw( DBIx::Class );

__PACKAGE__->load_components(qw/ TimeStamp Core /);

__PACKAGE__->table( 'event_user' );
__PACKAGE__->add_columns(
    "event_id",
    { data_type => 'INT', default_value => 0, is_nullable => 0 },
    "user_id",
    { data_type => 'INT', default_value => 0, is_nullable => 0 },
    created     => { data_type => 'datetime', set_on_create => 1, },
);

__PACKAGE__->set_primary_key( 'event_id', 'user_id' );
__PACKAGE__->resultset_attributes({ order_by => [ 'created' ] });

__PACKAGE__->belongs_to( 'user', 'Curs::Schema::Result::User', { 'foreign.id' => 'self.user_id' });
__PACKAGE__->belongs_to( 'event', 'Curs::Schema::Result::Event', { 'foreign.id' => 'self.event_id' });


1;
