package # hide from cpan!
    TestSchema;

use strict;
use warnings;

use DBICx::TestDatabase;

sub new {
    $ENV{DBIC_NO_VERSION_CHECK}++;
    my $schema = DBICx::TestDatabase->new( 'Curs::Schema' );
    return $schema;
}

1;

