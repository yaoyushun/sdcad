FastReport 2.53
for Delphi 3-7 & C++Builder 4-6


READ THIS FILE ACCURATELY BEFORE INSTALLING FR2.53!


VERY IMPORTANT! 
   Before installing, remove older packages of FastReport from the Delphi
component palette and remove paths to older version sources from
Tools->Environment Options->Library->Library Path!

----------------------------------------------------------------------------
TABLE OF CONTENTS

1. Introduction
2. Capabilities
3. Installing
4. Backward compatibility
5. Changes
6. Ordering
7. Notes
8. Credits
9. Other products recommended to use

----------------------------------------------------------------------------
1. INTRODUCTION
   FastReport is reporting tool component. It consists of report engine,
designer and preview. It written on 100% Object Pascal and can be installed
in Delphi 3-7 and C++Builder 4-6. Also available cross-platform version
FR CLX for Delphi 6,7 C++ Builder 6 and Kylix 1,2,3 - check out webpage to 
get latest information. 

   FastReport 2.53 is "try before buy". See "Ordering" topic for details.


----------------------------------------------------------------------------
2. CAPABILITIES
- Fast, compact and flexible code allows you to extend FR functionality.
  No additional DLLs needed.
- Built-in powerful and easy-to-use designer (also available in run-time).
- Suitable MSWord-like report preview with "Search text" and "Edit" functions.
- Set of most useful components: Text, Line, Picture, Shape, OLE, RichText,
  Chart, Barcode. You can also write your own components.
- Ability to export your reports to other formats (such as TXT, RTF, CSV,
  HTML, PDF and other). 
- Built-in Pascal-like language allows you write code without programming
  in Delphi. It allows you to create reports that can't be created in other
  tools.
- Script editor with syntax highligt.
- FR reports can contain dialogue forms that you can use to ask
  parameters before prepare a report. You can have as many dialogs as you need.
  FR uses the same designer for dialogs and have set of standart dialog
  controls like Button, Edit, CheckBox and other.
- Set of DB engines for FR allow you to create table/query/database components
  in run-time. Your reports can be completely independent of your application!
- FR can obtain data from tables and queries, arrays and data files - from
  any source. FR is not BDE-dependent, you can use it with *any* DB library
  that is based on standard TDataset component. You can also use FR with
  IB_Objects - powerful and wide-known library for Interbase DBMS.
- Localization in 21 languages. You can use FR in international applications.
- Full Bi-directional text output.


----------------------------------------------------------------------------
3. INSTALLING

   FR2.53 includes full source code. Trial version contains almost all sources
(only one compiled unit FR_Class.dcu / FR_class.obj ). 
! DON'T CHANGE ANYTHING IN FR.INC FILE OF TRIAL FR VERSION !

3.1. Run fr253.exe and follow to instructions of installation program

3.2. FastReport supports a significant number of languages.

   FastReport has several language sets: English, German, French, Danish, 
Portuguese-brazil, Spanish, Dutch, Swedish, Turkish, Italian, Polish, Czech, 
Hungarian, Slovene, Catalon, Slovak, Russian, Chinese, Ukrainian. 
   Resources are located in ..\FR\RES folder. By default, FastReport library 
setups with English resources. To use German resources, copy the files with 
RES-extensions from ..\FR\RES\GERMAN folder to ..\FR\SOURCE folder and 
recompile package (see more in setup.txt).
That way, you can make your application fully German, French etc


3.3. Installing additional components.
   There are three additional components included in standard FR package.
These components can be found in SOURCE\BDE, SOURCE\IBX and SOURCE\ADO
folders. They supersede old datamanager (TfrDataStorage component). To
install them, use same technique as described above. Each component have
a package file. To install in Delphi2, use file with Reg suffix (for example,
FR_BDEReg.pas).
   WARNING! The old datamanager (TfrDataStorage) is outdated. It included in
this FR version, but will be removed in the next version. We highly 
recommended to stop using it, move to new components and convert your existing
reports.

3.4. For recompile libraries see setup.txt

----------------------------------------------------------------------------
4. BACKWARD COMPATIBILITY
   .frf files from FR2.1...FR2.53 is compatible. You can use FR2.1 .frf
in FR2.4; but you can't use new .frf files in older FR versions and builds.
   See faq.txt if you want to open FreeReport 2.21 files.
   FR CLX files can be opened by FR2.45 version and higher. 
Since CLX and VCL uses different paper numbering you may need to change 
paper format after opening FR CLX report file. 
   Old datamanager (TfrDataManager) is not installed by default. Remove
comment from {$DEFINE DATAMANAGER} line in FR.inc file to install it.

----------------------------------------------------------------------------
5. Changes in FastReport v2.5:

- added improved text file export with dot-matrix printer support
- added HTML file export (based on table/styles)
- added Excel file export (based on XML (MS Office 2000/XP/2003 supported))
- modified Excel file export (OLE)
- modified RTF file export (table structure, MS Office 97-2003 supported)
- modified FastReport 3.0 (fr3) save from designer 
- Open QueryBuilder optional install 
- bug fixes.

See full changes list in file changes.txt

----------------------------------------------------------------------------
6. ORDERING
   FastReport 2.53 is "try before buy". You can try trial version of 
FastReport2.53, which prints only one page of report with nag label 
"FastReport - unregistered". Full version of FR shipped with full source code.
   Single copy of FR2.53 costs $99. Site license (unlimited number of copies)
costs $990. You can register it with RegisterNow! or ShareIt online services
which accepts all kinds of payment. 
  Use this link for register: http://www.fast-report.com/en/buynow.php 
Registered users gets technical support and can upgrade to the next
version of FR with no additional payment (FR CLX is separate product, you need
to buy it even if you already registered FR 2.53).

See Dealers.txt for more information about our resellers in countries.


----------------------------------------------------------------------------
7. NOTES
   All units written by authors, except the following:
 - RichEdit editor taked from \DEMOS\RICHEDIT.
 - Delphi version determining taken from RX 2.60.
 - TfrSpeedButton component is based on RX TrxSpeedButton.
 - Barcode component (frBarcod.pas) is written by Andreas Schmidt
   and friends (freeware).
 - See also "CREDITS" topic.


----------------------------------------------------------------------------
8. CREDITS

Olivier Guilbaud <golivier@free.fr>:
 - Barcode add-in (FR_BarC.pas)
 - RoundRect add-in (FR_RRect.pas)
 - Interface with OpenQueryBuilder (FR_QBEng.pas)

Dmitry Statilko <dima_misc@hotbox.ru>:
 - Flat comboboxes (FR_Combo.pas)

Andrew Semack <sammy@profix.poltava.ua>:
 - Interface with IB_Objects

EMS Company, Alexander Khvastunov <avx@ems.chel.su>:
 - TfrIBXComponents
 - TfrFIBComponents

Michael Shmakov <misha@petrosoft.karelia.ru>:
 - TfrDAOComponents

Andrew Dyrda <andrewdyrda@chat.ru>:
 - Documentation

Konstantin Butov <kos@sp.iae.nsk.su>:
 - Idea and first version of TfrPrintGrid component

Sergey Repalov <ReSerg@mail.ru>:
 - TfrRTF_RS_ExportFilter

Oleg Kharin <ok@uvadrev.udmnet.ru>:
 - Full WYSIWYG support

Stalker <stalker732_4@yahoo.com>:
 - A lot of suggestions and bug reports
 - TfrAsaComponents and others

Boris Loboda <barry@audit.kharkov.com>:
 - Help with hosting

Akzhan Abdulin <akzhan@mtgroup.ru>:
 - Life-time "moderatorial [-]" in RU.DELPHI :))

Pavel Ishenin <webpirat@mail.ru>
 - RTF, HTM export;
 - TfrCrossView enchancements

Vasilij Kirichenko <fr2html@mail.ru>
 - Advanced HTML export;

Gord Knight <gknight3@cogeco.ca>
 - moderator of FastReport's yahoo group

Pierre du Parte <fr@finalfiler.com>
 - moderator of FastReport's yahoo group

Localization:
 - Carsten Bech <carsten.bech@teliamail.dk> (danish)
 - Wy <wy6688@163.net> (chinese)
 - Roberto Mambriani <rmambriani@fasanocomputers.com> (italian)
 - Bartlomiej Zass <zass@pro.onet.pl> (polish)
 - Bolek Umnicki <strato@polandmail.com> (polish)
 - Josep Mas <xci@jet.es> (catalan)
 - Nei <coopcred@leosoft.com.br> (portuguese-brazil)
 - Isaque Pinheiro <axial@escelsa.com.br> (portuguese-brazil)
 - Bobby Gallagher <bobbyg@indigo.ie> (english)
 - Francisco Purrinos <purrinhos@cif.es> (spanish)
 - Andreas Pohl <apohl@ibp-consult.com> (german)
 - Stefan Diestelmann <sd@itsds.de> (german)
 - Arpad Toth <ekosoft@signalsoft.sk> (czech, slovak)
 - Le Hung <lehung@main.antszbar.hu> (hungary)
 - Tochenjuk Oleg <frodo@uct.kiev.ua> (ukrainian)
 - Pierre Demers <dempier2@hotmail.com> (french)
 - Olivier Guilbaud <golivier@free.fr> (french)
 - Craig Manley <c.manley@chello.nl> (dutch)
 - Burhan Chakmak <bakisoft@nursat.kz> (turkish)
 - Jan W <jan@ideida.se> (swedish)
 - Primoz Planinc <info@planles.net> (slovene)


Also thanks to all FR users who sent bugreports and suggestions!

9. OTHER PRODUCTS FastReport Software RECOMMENDED

 All the products in this chapter are fully compatible with FastReport and 
recommended to work with our product. 

                          AidAim Software
                          ---------------

AidAim Software team of highly professional developers working in the
fields of DBMS, cryptography and data compression is focused on the
building of components, libraries and tools for software developers.
AidAim Software provides the 24x7 support for customers as well as
consulting services in set forth above fields.
http://www.aidaim.com 

EasyTable: High-speed compact DB engine for Delphi and C++ Builder 
------------------------------------------------------------------
 
   Distribute your application with EasyTable and forget Borland Database
Engine (BDE). EasyTable is compact but powerful, EasyDB technology.
With EasyTable you don't need special installation and configuration, it
compiles right into your EXE. Make your application faster and smaller
using EasyTable database system. 
Key Features:
 No BDE; no DLLs; full source code included
 Unmatched ease-of-use
 Small footprint
 All tables in one database file
 Fully compatible with standard DB-aware controls
 Encryption, BLOB data compression and much more. 

Easy Compression Library: Gain the power of compression and encryption
----------------------------------------------------------------------

   With Easy Compression Library you can add advanced compression and
encryption functionality to your projects as quickly and easily as never
before. Based on new original One-Stream technology, this toolkit has
everything you need to compress and encrypt files, strings, data packets
and even BLOB fields.
Easy Compression Library provides a wide variety of compression algorithms,
so you can obtain high speed as well as high compression ratio that make
Easy Compression Library your best choice.
Key Features:
 A plenty of advanced compression algorithms
 Unmatched ease-of-use
 No DLLs, compiles right into your EXE; small customizable footprint
 Full compatible with Borland stream classes
 Strong encryption, compression on-the-fly, and much more.



----------------------------------------------------------------------------

FastReports Inc. 


e-mail:    info@fast-report.com
web sites: http://www.fast-report.com
           http://www.fastreports.net  
           http://www.fastreport.ru