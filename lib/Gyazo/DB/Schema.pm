package Gyazo::DB::Schema;
use strict;
use warnings;
use utf8;

use Teng::Schema::Declare;

base_row_class 'Gyazo::DB::Row';

table {
    name 'image';
    pk 'id';
    columns qw(id filename src ctime);
};

1;
