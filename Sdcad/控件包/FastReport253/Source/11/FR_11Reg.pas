
{******************************************}
{                                          }
{     FastReport v2.4 - 11 components     }
{            Registration unit             }
{                                          }
{ Copyright (c) 1998-2001 by Tzyganenko A. }
{                                          }
{******************************************}

unit FR_11reg;

interface

{$I FR.inc}

procedure Register;

implementation

uses
  Windows, Messages, SysUtils, Classes
{$IFNDEF Delphi6}
, DsgnIntf
{$ELSE}
, DesignIntf, DesignEditors
{$ENDIF}
, FR_11DB;


procedure Register;
begin
  RegisterComponents('FastReport', [Tfr11Components]);
end;

end.
