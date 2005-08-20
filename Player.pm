package DCOP::Amarok::Player;

use 5.008001;
use strict;
use warnings;

require DCOP::Amarok;

our @ISA = qw(DCOP::Amarok);

our $VERSION = '0.031';

=head1 NAME

DCOP::Amarok::Player - Perl extension to speak to an amaroK player object via system's DCOP.

=head1 SYNOPSIS

	use DCOP::Amarok::Player;
	$player = DCOP::Amarok::Player->new();
	
	$player->playPause();
	print $player->getRandom();

=head1 DESCRIPTION

This module is a quick hack to get an interface between perl and Kde's DCOP,
since Kde3.4's perl bindings are disabled. This suite talks to 'dcop'.
DCOP::Amarok::Player talks directly to the player object of amaroK.

=head1 EXPORT

None by default.

=head1 METHODS

=item new()

Constructor. No arguments needed. If the program will be run remotely, the
need for 'user => "myusername"' arises.

=cut

sub new {
	my $proto = shift;
	my $class = ref($proto) || $proto;
	my %params = @_;
	my $self  = $class->SUPER::new(%params, control => "player" );
	bless ($self, $class);
	return $self;
}

=item album()

Returns the album name of currently playing song.

=cut
	
sub album() {
	my $self = shift;
	chomp( $_ = `$self->{dcop} album` );
	return $_;
}

=item artist()

Returns the artist performing currently playing song.

=cut

sub artist() {
	my $self = shift;
	chomp( $_ = `$self->{dcop} artist` );
	return $_;
}

=item title()

Returns the title of currently playing song.

=cut

sub title() {
	my $self = shift;
	chomp( $_ = `$self->{dcop} title` );
	return $_;
}

=item playPause()

=cut

sub playPause() {
	my $self = shift;
	system("$self->{dcop} playPause");
}

=item stop()

=cut

sub stop() {
	my $self = shift;
	system("$self->{dcop} stop");
}

=item next()

=cut

sub next() {
	my $self = shift;
	system("$self->{dcop} next");
}

=item prev()

=cut

sub prev() {
	my $self = shift;
	system("$self->{dcop} prev");
}

=item getRandom()

Returns the status of the Shuffle play mode.

=cut

sub getRandom(){
	my $self = shift;
	chomp($_=`$self->{dcop} randomModeStatus`);
	return $_;
}

=item toggleRandom()

Toggles the Shuffle play mode. Returns the new state.

=cut

sub toggleRandom() {
# returns new status of randomness
	my $self = shift;
	chomp( $_ = `$self->{dcop} randomModeStatus` );
	if ( $_ =~ /true/ ) {
		system("$self->{dcop} enableRandomMode 0");
	}
	else {
		system("$self->{dcop} enableRandomMode 1");
	}
	chomp( $_ = `$self->{dcop} randomModeStatus` );
	return $_;
}

=item mute()

=cut

sub mute() {
	my $self = shift;
	system("$self->{dcop} mute");
}

=item volUp()

=cut 

sub volUp() {
	my $self = shift;
	system("$self->{dcop} volumeUp");
}

=item volDn()

=cut

sub volDn() {
	my $self = shift;
	system("$self->{dcop} volumeDown");
}

=item vol()

Returns the volume level.

=cut

sub vol() {
	my $self = shift;
	chomp( $_ = `$self->{dcop} getVolume` );
	return $_;
}

=item status()

Returns the playing status of amaroK. 
0: Stopped, 1: Paused, 2: Playing

=cut

sub status() {
	my $self = shift;
	chomp( $_ = `$self->{dcop} status` );
	return $_;
}

=item track()

Returns the track number of the song that is currently being played.

=cut

sub track(){
	my $self = shift;
	chomp($_=`$self->{dcop} track`);
	return $_;
}

=item totaltime()

Returns in MM:SS the total playing time of the song that is currently being played.

=cut

sub totaltime(){
	my $self = shift;
	chomp($_=`$self->{dcop} totalTime`);
	return $_;
}

=item elapsed()

Returns in MM:SS the elapsed time of the song that is currently being played.

=cut
		
sub elapsed(){
	my $self = shift;
	chomp($_=`$self->{dcop} currentTime`);
	return $_;
}

=item totaltimesecs()

Returns in seconds the total playing time of the song that is currently being played.

=cut
		
sub totaltimesecs(){
	my $self = shift;
	chomp($_=`$self->{dcop} trackTotalTime`);
	return $_;
}

=item elapsedsecs()

Returns in seconds the elapsed time of the song that is currently being played.

=cut

sub elapsedsecs(){
	my $self = shift;
	chomp($_=`$self->{dcop} trackCurrentTime`);
	return $_;
}

sub _mins(){
	my $self = shift;
	my $totsecs = shift;
	my $secs = $totsecs % 60;
	my $mins = ($totsecs-$secs)/60;
	$secs = '0'.$secs if($secs<10);
	return "${mins}:${secs}";
}

=item fwd()

Fast forwards 5 seconds the song.

=cut

sub fwd(){
	my $self = shift;
	system("$self->{dcop} seekRelative +5");
}

=item rew()

Rewinds 5 seconds the song.

=cut

sub rew(){
	my $self = shift;
	system("$self->{dcop} seekRelative -5");
}

=item lyrics()

Returns the lyrics of the song that is currently being played.

=cut

sub lyrics(){
	my $self = shift;
	chomp($_=`$self->{dcop} lyrics`);
	return $_;
}

1;
__END__

=head1 AUTHOR

Juan C. Muller, E<lt>jcmuller@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2005 by Juan C. Muller

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

