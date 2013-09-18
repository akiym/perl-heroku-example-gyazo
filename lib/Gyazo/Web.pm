package Gyazo::Web;
use strict;
use warnings;
use utf8;
use parent qw/Gyazo Amon2::Web/;
use File::Spec;

# dispatcher
use Gyazo::Web::Dispatcher;
sub dispatch {
    return (Gyazo::Web::Dispatcher->dispatch($_[0]) or die "response is not generated");
}

# setup view
use Gyazo::Web::View;
{
    my $view = Gyazo::Web::View->make_instance(__PACKAGE__);
    sub create_view { $view }
}

# for your security
__PACKAGE__->add_trigger(
    AFTER_DISPATCH => sub {
        my ( $c, $res ) = @_;

        # http://blogs.msdn.com/b/ie/archive/2008/07/02/ie8-security-part-v-comprehensive-protection.aspx
        $res->header( 'X-Content-Type-Options' => 'nosniff' );

        # http://blog.mozilla.com/security/2010/09/08/x-frame-options/
        $res->header( 'X-Frame-Options' => 'DENY' );

        # Cache control.
        $res->header( 'Cache-Control' => 'private' );
    },
);

1;
