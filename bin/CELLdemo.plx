#!perl
use strict;
use warnings;

use App::CELL qw( $CELL $log $meta $core $site );
use Data::Dumper;
use File::Spec;
my ( undef, $basedir, $basename ) = File::Spec->splitpath( $0 );
print Dumper( $basedir );
print Dumper( $basename );
use Log::Any::Adapter( 'File', File::Spec->catfile(
            'bin/', 'CELLdemo.log',
        ) 
    );

$log->init( ident => 'CELLdemo', debug_mode => 1 );

print $site->CELL_SHAREDIR_LOADED ? "Sharedir loaded\n" : "Sharedir not loaded\n";
print "\$CELL->loaded == ", $CELL->loaded, "\n";
my $status = $CELL->load;
print $status->dump();
print $site->CELL_SHAREDIR_LOADED ? "Sharedir loaded\n" : "Sharedir not loaded\n";
print "\$CELL->loaded == ", $CELL->loaded, "\n";
# print( Dumper( $status ) ) if $status->not_ok;
# exit(-1);

print "App::CELL supports the following languages: ", @{ $site->CELL_SUPP_LANG }, "\n";

print "CELL_CORE_SAMPLE: ", $site->CELL_CORE_SAMPLE, "\n";
$site->set( 'CELL_CORE_SAMPLE', "foobar" );
print "CELL_CORE_SAMPLE: ", $site->CELL_CORE_SAMPLE, "\n";

$status = $CELL->status_warn( 'CELL_TEST_MESSAGE' );
$status->dump( fd => \*STDOUT );

$log->debug( "CELLtest.plx ending" );

__END__

=pod

=head1 NAME

demo.plx - demonstrate how App::CELL might be used

=cut
