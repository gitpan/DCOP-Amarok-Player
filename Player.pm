package DCOP::Amarok::Player;

use 5.008001;
use strict;
use warnings;

require DCOP::Amarok;

our @ISA = qw(DCOP::Amarok);

our $VERSION = '0.01';

sub new {
	my $proto = shift;
	my $class = ref($proto) || $proto;
	my %params = @_;
	my $self  = $class->SUPER::new(%params, control => "player" );
	bless ($self, $class);
	return $self;
}

sub album() {
	my $self = shift;
	chomp( $_ = `$self->{dcop} album` );
	return $_;
}

sub artist() {
	my $self = shift;
	chomp( $_ = `$self->{dcop} artist` );
	return $_;
}

sub title() {
	my $self = shift;
	chomp( $_ = `$self->{dcop} title` );
	return $_;
}

sub playPause() {
	my $self = shift;
	system("$self->{dcop} playPause");
}

sub stop() {
	my $self = shift;
	system("$self->{dcop} stop");
}

sub next() {
	my $self = shift;
	system("$self->{dcop} next");
}

sub prev() {
	my $self = shift;
	system("$self->{dcop} prev");
}

sub getRandom(){
	my $self = shift;
	chomp($_=`$self->{dcop} randomModeStatus`);
	return $_;
}

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

sub mute() {
	my $self = shift;
	system("$self->{dcop} mute");
}

sub volUp() {
	my $self = shift;
	system("$self->{dcop} volumeUp");
}

sub volDn() {
	my $self = shift;
	system("$self->{dcop} volumeDown");
}

sub vol() {
	my $self = shift;
	chomp( $_ = `$self->{dcop} getVolume` );
	return $_;
}

sub status() {
	my $self = shift;
	chomp( $_ = `$self->{dcop} status` );
	return $_;
}

sub track(){
	my $self = shift;
	chomp($_=`$self->{dcop} track`);
	return $_;
}

sub totaltime(){
	my $self = shift;
	chomp($_=`$self->{dcop} totalTime`);
	return $_;
}

sub elapsed(){
	my $self = shift;
	chomp($_=`$self->{dcop} trackCurrentTime`);
	return $self->_mins($_);
}

sub _mins(){
	my $self = shift;
	my $totsecs = shift;
	my $secs = $totsecs % 60;
	my $mins = ($totsecs-$secs)/60;
	$secs = '0'.$secs if($secs<10);
	return "${mins}:${secs}";
}

sub fwd(){
	my $self = shift;
	system("$self->{dcop} seekRelative +5");
}

sub rew(){
	my $self = shift;
	system("$self->{dcop} seekRelative -5");
}
1;
__END__
# Below is stub documentation for your module. You'd better edit it!

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

=head2 EXPORT

None by default.

=head1 SEE ALSO


=head1 AUTHOR

Juan C. Müller, E<lt>jcmuller@gmail.com<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2005 by Juan C. Müller

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
