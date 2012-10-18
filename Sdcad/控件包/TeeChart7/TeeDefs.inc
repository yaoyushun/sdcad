// TeeChart Pro Defines
// See modifiable User Options below ...
{$H+}

{$IFDEF CLR}
{$DEFINE TEENOASM}   // ASM (Inline Assembler) not supported in .NET
{$DEFINE TEESAFECLR} // Force "Safe" managed code only.
{$FINITEFLOAT OFF}   // Turn off floating-point exceptions to speed performance
{$ENDIF}

{$DEFINE TEEVCL}  // Do not undefine TEEVCL !

{$DEFINE TEEEDITORS}

{$IFDEF VER160}
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE D5}
  {$DEFINE C5}
  {$DEFINE D6}
  {$DEFINE D7}
  {$IFDEF BCB}
    {$DEFINE C6}
  {$ENDIF}
  {$DEFINE NET}
{$ENDIF}

{$IFDEF VER150}
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE D5}
  {$DEFINE C5}
  {$DEFINE D6}
  {$DEFINE D7}
  {$IFDEF BCB}
    {$DEFINE C6}
  {$ENDIF}
{$ENDIF}

{$IFDEF VER145}
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE D5}
  {$DEFINE C5}
  {$DEFINE D6}
  {$IFDEF BCB}
    {$DEFINE C6}
  {$ENDIF}
  {$DEFINE K3}
{$ENDIF}

{$IFDEF CONDITIONALEXPRESSIONS}

  {$IFDEF LINUX}
   {$IF Declared(RTLVersion) and (RTLVersion>14.0)}
    {$DEFINE K3}
   {$IFEND}
  {$ENDIF}

  {$IFDEF BCB}
   {$IF Declared(RTLVersion) and (RTLVersion>=14.5)}

    {$DEFINE D3}
    {$DEFINE D4}
    {$DEFINE D5}
    {$DEFINE C5}
    {$DEFINE D6}
    {$DEFINE D7}
    {$DEFINE C7}
   {$IFEND}
  {$ENDIF}

{$ENDIF}

{$IFDEF VER140}
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE D5}
  {$DEFINE C5}
  {$DEFINE D6}
  {$IFDEF BCB}
    {$DEFINE C6}
  {$ENDIF}  
{$ENDIF}
{$IFDEF VER130}
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE D5}
  {$DEFINE C4}
  {$DEFINE C5}
{$ENDIF}
{$IFDEF VER125}
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE C3D4}
  {$DEFINE C4}
{$ENDIF}
{$IFDEF VER120}
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE C3D4}
{$ENDIF}
{$IFDEF VER110}
  {$DEFINE D3}
  {$IFDEF BCB}
    {$DEFINE C3}
    {$DEFINE C3D4}
  {$ELSE}
    {$DEFINE D4}
    {$DEFINE C3D4}
  {$ENDIF}
{$ENDIF}

{$IFDEF DECLARE_GPL}
{$DEFINE KYLIXOPEN}
{$ENDIF}

{$IFDEF BCB}
{$ObjExportAll On}
{$ENDIF}

{$IFDEF VER80}
  'Error: TeeChart 6 does not support Delphi 1 and 2. Use TeeChart v4.'
{$ENDIF}
{$IFDEF VER100}
  'Error: TeeChart 6 does not support Delphi 3. Use TeeChart v5.'
{$ENDIF}


{$IFDEF D6}
{.$DEFINE CLX}
{$ENDIF}

{$IFDEF LINUX}
{$DEFINE CLX}
{$ENDIF}

{$IFDEF D6}
{$DEFINE D6DESIGNER}
{$ELSE}
{$IFDEF CLX}
{$DEFINE D6DESIGNER}
{$ENDIF}
{$ENDIF}

{$IFDEF D7}
{$IFNDEF K3}
  {$WARN UNSAFE_TYPE OFF}
  {$WARN UNSAFE_CODE OFF}
  {$WARN UNSAFE_CAST OFF}
{$ENDIF}
{$ENDIF}

// User Options
// =====================

{.$DEFINE NOUSE_BDE}      // <-- remove the "." to avoid using the BDE (in QRChart, etc)
{.$DEFINE TEEMULTIPLIER}  // <-- remove the "." to enable "Multiplier" property. (slower)

{$IFDEF D5}
{.$DEFINE TEEENTERPRISE}  // <-- remove the "." to add ADO support in TeeChart Wizard
{$ENDIF}

{$IFDEF D4}

// TList     = less speed modifying values, more speed deleting values, much MORE memory
// Dyn Array = Direct access to values, more speed modifying values, much LESS memory,
//             less speed deleting values. Not for Delphi 3.

{$DEFINE TEEARRAY}  // <-- put a "." in front to use TList instead of Dynamic Arrays

{$ENDIF}

{$IFNDEF TEEVALUESINGLE}
{$IFNDEF TEEVALUEEXTENDED}

// "Value" type for points data.
// Remove the "." on ONLY one of the items below:

{$DEFINE TEEVALUEDOUBLE}
{.$DEFINE TEEVALUESINGLE}
{.$DEFINE TEEVALUEEXTENDED}

{$ENDIF}
{$ENDIF}

