package Curs::Schema::ResultSet::Event;
use parent qw( DBIx::Class::ResultSet );
use DateTime;

=head2 current
=cut
sub current {
    my( $self, $args, $opts ) = @_;
    $query ||= {};
    $opts  ||= {};

    $query->{start}   = { '<=' => DateTime->today };
    $opts->{order_by} = { order_by => 'start ASC' };

    $self->search( $query, $opts );
}

=head2 past
=cut
sub past {
    my( $self, $args, $opts ) = @_;
    $query ||= {};
    $opts  ||= {};

    $query->{end}   = { '<' => DateTime->today };
    $opts->{order_by} = { order_by => 'end DESC' };

    $self->search( $query, $opts );
}

1;
