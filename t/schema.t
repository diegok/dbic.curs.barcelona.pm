use strict;
use warnings;
use Test::More 'no_plan';
use v5.10;

use lib 't/lib';
BEGIN { use_ok 'TestSchema' }

ok ( my $schema = TestSchema->new(), 'Create a schema object' );
isa_ok ( $schema, 'Curs::Schema');

ok ( my $admin = $schema->resultset('User')->create({
        email    => 'admin@curs.perl.cat',
        password => 'admin',
        name     => 'Super user for barcelona.pm'
    }), 'Create user' );
ok ( $admin->add_to_roles({ name => 'user' }), 'Give role user to user :-)' );
ok ( $admin->add_to_roles({ name => 'admin' }), 'Give role admin to user' );

ok ( my $user = $schema->resultset('User')->create({
        email    => 'user@curs.perl.cat',
        password => 'user',
        name     => 'Default user'
    }), 'Create user' );
ok ( $user->add_to_roles({ name => 'user' }), 'Give role user to user :-)' );

ok ( my $event = $schema->resultset('Event')->create({
        title       => 'Curs avançat de Perl',
        description => 'Something nice to do on a saturday!',
        creator_id  => $admin->id,
        start       => DateTime->new( year => 2012, month => 3, day => 10, hour => 9 ),
        end         => DateTime->new( year => 2012, month => 3, day => 10, hour => 9, minute => 15 ),
    }), 'Create event');

if ( $schema->resultset('Event')->current->count ) {
    diag 'Veo que estas en el curso!';
}
