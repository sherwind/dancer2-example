requires "Dancer2" => "0.166001";
requires "Dancer2::Plugin::Deferred";
requires "Dancer2::Plugin::DBIC";
requires "DBD::SQLite";
requires "Template";
requires "Template::Plugin::Gravatar";
requires "HTML::FormHandler";
requires "HTML::FormHandler::Model::DBIC";
requires "DBIx::Class::PassphraseColumn";
requires "YAML";

recommends "YAML::XS"         => "0";
recommends "URL::Encode::XS"  => "0";
recommends "CGI::Deurl::XS"   => "0";
recommends "HTTP::Parser::XS" => "0";

on "test" => sub {
    requires "Test::More"            => "0";
    requires "HTTP::Request::Common" => "0";
};
