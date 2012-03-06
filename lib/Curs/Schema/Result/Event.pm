package Curs::Schema::Result::Event;
use strict; use warnings;
use parent 'DBIx::Class';
use Text::Unidecode qw();

__PACKAGE__->load_components(qw/ TimeStamp Core /);

__PACKAGE__->table( 'event' );
__PACKAGE__->add_columns(
    id          => { data_type => 'int',      is_nullable => 0, is_auto_increment => 1 },
    title       => { data_type => 'varchar',  is_nullable => 0, size => 255 },
    description => { data_type => 'text',     is_nullable => 1 },
    created     => { data_type => 'datetime', set_on_create => 1, },
    updated     => { data_type => 'datetime', set_on_create => 1, set_on_update => 1, },
    start       => { data_type => 'datetime', is_nullable => 1 },
    end         => { data_type => 'datetime', is_nullable => 1 },
    creator_id  => { data_type => 'int',      is_nullable => 0 },
);

__PACKAGE__->set_primary_key( 'id' );
__PACKAGE__->has_many( 'rel_attendees', 'Curs::Schema::Result::EventUser', { 'foreign.event_id' => 'self.id' }, { cascade_delete => 1 });
__PACKAGE__->many_to_many( 'attendees', 'rel_attendees', 'user' );

=head2 sqlt_deploy_hook
 Create indexes on deploy
=cut
sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $sqlt_table->add_index( name => 'creation_idx',  fields => [qw/ created /] );
    $sqlt_table->add_index( name => 'updated_idx',   fields => [qw/ updated /] );
    $sqlt_table->add_index( name => 'dateframe_idx', fields => [qw/ start end /] );
}  

#TODO: generate slug (add slug field with unique index)
sub insert {
    my $self = shift;
    $self->next::method(@_);
}

sub update {
    my $self = shift;
    $self->next::method(@_);
}

1;
