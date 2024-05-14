package SortKey::Num::similarity_jaccard;

use 5.010001;
use strict;
use warnings;
use Log::ger;

use Set::Similarity::Jaccard;

# AUTHORITY
# DATE
# DIST
# VERSION

sub meta {
    return +{
        v => 1,
        args => {
            string => {schema=>'str*', req=>1},
            ci => {schema => 'bool*'},
        },
    };
}

sub gen_keygen {
    my %args = @_;

    my $string = $args{string};
    my $lc_string = lc $string;
    my $ci = $args{ci};

    my $jaccard = Set::Similarity::Jaccard->new;

    sub {
        $ci ? $jaccard->similarity($lc_string, lc($_[0])) : $jaccard->similarity($string, $_[0]);
    };
}

1;
# ABSTRACT: Jaccard coefficient of a string to a reference string, as sort key

=for Pod::Coverage ^(meta|gen_comparer)$

=head1 SYNOPSIS

 use Sort::Key qw(nkeysort);
 use SortKey::Num::similarity_jaccard;

 my $keygen = SortKey::Num::similarity_jaccard::gen_keygen(string => 'foo');
 my @sorted = &nkeysort($keygen, "food", "foolish", "foo", "bar");
 # => ("foo","food","bar","foolish")


=head1 DESCRIPTION

=cut
