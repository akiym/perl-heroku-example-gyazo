package Gyazo;
use strict;
use warnings;
use utf8;
use parent qw/Amon2/;
our $VERSION='4.03';
use 5.008001;
use Gyazo::DB::Schema;
use Gyazo::DB;

my $schema = Gyazo::DB::Schema->instance;

sub db {
    my $c = shift;
    if (!exists $c->{db}) {
        my $conf = $c->config->{DBI}
            or die "Missing configuration about DBI";
        $c->{db} = Gyazo::DB->new(
            schema       => $schema,
            connect_info => [@$conf],
            # I suggest to enable following lines if you are using mysql.
            # on_connect_do => [
            #     'SET SESSION sql_mode=STRICT_TRANS_TABLES;',
            # ],
        );
    }
    $c->{db};
}

1;
