#!/usr/bin/perl -w

use Test::More tests => 5;

BEGIN { use_ok('DCOP::Amarok::Player') };
my $player = DCOP::Amarok::Player->new();
ok( defined $player, "new() defined the object" );
ok( $player->isa(DCOP::Amarok::Player), "   Object belongs to the class" );

SKIP: {
	skip( "Only works when amarok is installed", 6 ) if( !`amarok --version` );
	
	is( $player->playPause(), 0,	"   PlayPause" );
	is( $player->stop(), 0, 		"   Stop" );
}
