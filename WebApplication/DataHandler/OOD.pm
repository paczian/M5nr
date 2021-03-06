package DataHandler::OOD;

# DataHandler::OOD - data handler to the PPO OOD database

# $Id: OOD.pm,v 1.6 2010-03-17 23:04:33 wilke Exp $

use strict;
use warnings;

use base qw( DataHandler );

use DBMaster;
use FIG_Config;


=pod

=head1 NAME

DataHandler::RAST - data handler to the PPO RAST database

=head1 DESCRIPTION

This module returns the DBMaster object to the RAST database stored in the root
job directory of a RAST server. It requires the FIG_Config.pm to specify the  
$rast_jobs directory.

Refer to WebApplication/DataHandler.pm for the full documentation.

=head1 METHODS

=over 4

=item * B<handle> ()

Returns the enclosed data handle. Returns undef if it fails to open the Jobs database

=cut

sub handle {

  unless ($FIG_Config::OOD_ontology_db) {
    warn "Unable to read DataHandler::OOD database: OOD_ontology_db not defined in FIG_Config.pm\n";
    return undef;
  }
  unless ($FIG_Config::OOD_ontology_dbuser) {
    warn "Unable to read DataHandler::OOD database: OOD_ontology_dbuser not defined in FIG_Config.pm\n";
    return undef;
  }
  unless ($FIG_Config::OOD_ontology_dbhost) {
    warn "Unable to read DataHandler::OOD database: OOD_ontology_dbhost not defined in FIG_Config.pm\n";
    return undef;
  }

  unless (exists $_[0]->{_handle}) {
  
    eval {
      $_[0]->{_handle} = DBMaster->new( -database => $FIG_Config::OOD_ontology_db,
 					-host     => $FIG_Config::OOD_ontology_dbhost,
 					-user     => $FIG_Config::OOD_ontology_dbuser,
 					-backend  => 'MySQL',
				      );
   #    $_[0]->{_handle} = DBMaster->new( -database => $FIG_Config::mgrast_ontology,
					
# 				      );
    };
    if ($@) {
      warn "Unable to read DataHandler::OOD database: $@\n";
      $_[0]->{_handle} = undef;
    }
  }
  return $_[0]->{_handle};
}

1;
