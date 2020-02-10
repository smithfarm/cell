#!perl
use strict;
use warnings;

use App::CELL qw( $CELL $log $meta $core $site );
use Data::Dumper;
use File::HomeDir;
use File::ShareDir;
use File::Spec;
use File::Touch;
use Log::Any::Adapter ('File', File::Spec->catfile ( 
            File::HomeDir::my_home(), 'tmp', 'CELLdemo.log',
        ) 
    );

$log->init( ident => 'CELLdemo', debug_mode => 1 );

print $site->CELL_SHAREDIR_LOADED ? "Sharedir loaded\n" : "Sharedir not loaded\n";
my $status = $CELL->load;
print $site->CELL_SHAREDIR_LOADED ? "Sharedir loaded\n" : "Sharedir not loaded\n";
# print( Dumper( $status ) ) if $status->not_ok;
# exit(-1);

print "App::CELL supports the following languages: ", @{ $site->CELL_SUPP_LANG }, "\n";

print "CELL_CORE_SAMPLE: ", $site->CELL_CORE_SAMPLE, "\n";
$site->set( 'CELL_CORE_SAMPLE', "foobar" );
print "CELL_CORE_SAMPLE: ", $site->CELL_CORE_SAMPLE, "\n";
$log->debug( "CELLtest.plx ending" );

__END__

=pod

=head1 NAME

demo.plx - demonstrate how App::CELL might be used

=cut
