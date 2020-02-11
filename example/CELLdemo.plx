#!/usr/bin/perl

#
# example/CELLdemo.plx
# 
# How to run:
#
#     $ perl -I . example/CELLdemo.plx
#

use strict;
use warnings;

use App::CELL qw( $CELL $log $meta $core $site );
use Data::Dumper;
use File::Spec;
my ( undef, $basedir, $basename ) = File::Spec->splitpath( $0 );
print "\$basedir == ", $basedir, "\n";
use Log::Any::Adapter( 'Stdout' );
#use Log::Any::Adapter(
#    'File',
#    $basedir ? File::Spec->catfile( $basedir, 'CELLdemo.log') : 'CELLdemo.log'
#);

$log->init( ident => 'CELLdemo' );

print $site->CELL_SHAREDIR_LOADED ? "Sharedir loaded\n" : "Sharedir not loaded\n";
print "\$CELL->loaded == ", $CELL->loaded, "\n";
my $status = $CELL->load( sitedir => $basedir ? $basedir : '.' );
$status->dump( fd => \*STDOUT ) if $status->not_ok;
if ( $site->CELL_SHAREDIR_LOADED ) {
    print "Sharedir " . $site->CELL_SHAREDIR_FULLPATH . " loaded\n"
}
print "\$CELL->loaded == ", $CELL->loaded, "\n";
print "\$meta->CELL_META_SITEDIR_LOADED == ", $meta->CELL_META_SITEDIR_LOADED, "\n";
print "\$meta->CELL_META_SITEDIR_LIST == ", @{ $meta->CELL_META_SITEDIR_LIST }, "\n";

print "App::CELL supports the following languages: ", @{ $site->CELL_SUPP_LANG }, "\n";

print "CELL_CORE_SAMPLE: ", $site->CELL_CORE_SAMPLE, "\n";
$site->set( 'CELL_CORE_SAMPLE', "foobar" );
print "CELL_CORE_SAMPLE: ", $site->CELL_CORE_SAMPLE, "\n";

print "Creating a status object causes a log message to be emitted.", "\n";
$status = $CELL->status_warn( 'CELL_TEST_MESSAGE' );
$status->dump( fd => \*STDOUT );
$status = $CELL->status_info( 'CELLDEMO_ACHES_AND_PAINS' );
$status->dump( fd => \*STDOUT );

$log->debug( "CELLtest.plx ending" );

__END__

=pod

=head1 NAME

demo.plx - demonstrate how App::CELL might be used

=cut
