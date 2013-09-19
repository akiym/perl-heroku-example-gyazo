package Gyazo::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::Lite;
use DBD::Pg;
use Digest::MD5 qw/md5_hex/;

post '/upload' => sub {
    my ($c) = @_;
    my $imagedata = $c->req->upload('imagedata') or die;
    # アップロードできる画像は1MB未満とする
    die unless $imagedata->size < 1024 * 1024;

    # 画像データを読み込む
    my $src = do {
        open my $fh, '<:raw', $imagedata->path or die $!;
        local $/; <$fh>;
    };
    # PNGであることをシグネチャで判定する
    die unless $src =~ /^\x89PNG\x0d\x0a\x1a\x0a/;

    my $filename = md5_hex($src) . '.png';
    $c->db->fast_insert('image', {
        filename => $filename,
        src      => [$src, {pg_type => DBD::Pg::PG_BYTEA}],
        ctime    => time(),
    });

    my $url = $c->req->base . $filename;
    return $c->create_response(200, [], [$url]);
};

1;
