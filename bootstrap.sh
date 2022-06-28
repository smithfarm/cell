#!/bin/bash
set -e
sudo zypper --gpg-auto-import-keys --non-interactive refresh
sudo zypper --non-interactive install \
    perl-File-Next \
    perl-Log-Any \
    perl-Params-Validate \
    perl-File-ShareDir-Install \
    perl-Test-Output \
    perl-Test-Warnings \
    perl-Perl-Version \
    perl-CPAN-Uploader \
    cpanspec
perl Build.PL
./Build
sudo ./Build install
prove -l t/
