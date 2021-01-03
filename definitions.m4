changequote({{,}})dnl
dnl# root definitions import first
dnl#syscmd(echo "Author: " | tr -d '\n')dnl
dnl#pushdef({{__author__}}, esyscmd(read AUTHOR && echo $AUTHOR | tr -d '\n'))dnl
pushdef({{__author__}}, {{Betsalel (Saul) Williamson}})dnl
dnl
dnl
dnl#syscmd(echo "Author Email: " | tr -d '\n')dnl
dnl#pushdef({{__author_email__}}, esyscmd(read AUTHOR_EMAIL && echo $AUTHOR_EMAIL | tr -d '\n'))dnl
pushdef({{__author_email__}}, {{saul.williamson@ieee.org}})dnl
dnl
dnl
pushdef({{__wiki_licence__}}, {{CC BY 4.0 license}})dnl
pushdef({{__wiki_licence_full__}}, {{Creative Commons 4.0 Attribution License}})dnl
pushdef({{__wiki_licence_web_address__}}, {{https://creativecommons.org/licenses/by/4.0/}})dnl
dnl
dnl
pushdef({{__project_repo_root__}}, {{https://github.com/betsalel-williamson/Programming-Tutorial}})dnl
pushdef({{__project_repo__}}, {{__project_repo_root__{{}}.git}})dnl
pushdef({{__project_repo_source_root__}}, {{__project_repo_root__{{}}/tree/main/src}})dnl
pushdef({{__project_repo_name__}}, {{Programming-Tutorial}})dnl
pushdef({{__code_license_header__}}, {{The author disclaims copyright to this source code.  In place of
a legal notice, here is a blessing:
   May you do good and not evil.
   May you find forgiveness for yourself and forgive others.
   May you share freely, never taking more than you give.}})dnl
pushdef({{__code_license_header_hash_style__}}, {{# The author disclaims copyright to this source code.  In place of
# a legal notice, here is a blessing:
#    May you do good and not evil.
#    May you find forgiveness for yourself and forgive others.
#    May you share freely, never taking more than you give.}})dnl
pushdef({{__code_license_header_c__}}, {{/*
** The author disclaims copyright to this source code.  In place of
** a legal notice, here is a blessing:
**
**    May you do good and not evil.
**    May you find forgiveness for yourself and forgive others.
**    May you share freely, never taking more than you give.
*/}})dnl
pushdef({{__code_license_header_markdown__}}, {{In place of a legal notice, here is a blessing:
- May you do good and not evil.
- May you find forgiveness for yourself and forgive others.
- May you share freely, never taking more than you give.}})dnl
pushdef({{__project_under_construction_flag__}}, {{# Warning !!! This tutorial is currently under construction... Proceed at your own risk
}})dnl
