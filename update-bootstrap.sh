#!/bin/bash
# Inspired by bootstrap-sass(https://github.com/thomas-mcdonald/bootstrap-sass)

ROOT=`dirname $0`"/vendor/assets"
TMP='tmp/jasny-bootstrap'

# Pull down jasny/bootstrap sources
git clone https://github.com/jasny/bootstrap.git $TMP
# Copy less/ to stylesheets/
mkdir -p $ROOT/stylesheets/bootstrap
cp -r $TMP/less/* $ROOT/stylesheets/bootstrap
# Copy js/ to javascripts/
cp -r $TMP/js/* $ROOT/javascripts
# Copy img/ to images/
cp -r $TMP/img/* $ROOT/images
# Copy font/ to images/
cp -r $TMP/font/* $ROOT/fonts
# Remove tests
rm -r $ROOT/javascripts/tests
rm -r $ROOT/stylesheets/bootstrap/tests

#TODO
# Patch the asset-url in _variables.scss
patch -f $ROOT/stylesheets/bootstrap/_variables.scss < asseturl.patch

# Patch paths in bootstrap.scss and responsive.scss
sed -i .bak 's_@import \"_@import \"bootstrap/_g' $ROOT/stylesheets/bootstrap/{bootstrap,responsive}.scss
rm $ROOT/stylesheets/bootstrap/*.bak

rm -rf $TMP
