unit Hash;

interface

uses
  SysUtils,
  Classes;

type
  THashItem = class(TObject)
  private
    FHashIndex: Integer;
    FNext, FPrev,               // global item list
    FBucketNext, FBucketPrev: THashItem;  // bucket list
    FKey,
    FValue: Variant;
  public
    property HashIndex: Integer read FHashIndex;
    property Key: Variant read FKey;
    property Value: Variant read FValue write FValue;
  end;

  TBucket = record
    Count: Integer;
    FirstItem: THashItem;
  end;

  THashArray = array[0..0] of TBucket;
  PHashArray = ^THashArray;

  EHashError = class(Exception);

  THashErrMsg = (
                 hKeyNotFound,
                 hKeyExists,
                 hIndexOutOfBounds
                );

  TCustomHashTable = class(TObject)
  private
    FItems: THashItem;
    FHash: PHashArray;
    FHashCount: Integer;
    function FindItem(const Key: Variant; bQuiet: Boolean;
      HashVal: Integer): THashItem;
    procedure HashError(const ErrMsg: THashErrMsg);
    function GetValue(const Key: Variant): Variant;
    procedure SetValue(const Key: Variant; Value: Variant);
  protected
    function HashSize: Integer; virtual; abstract;
    property Count: Integer read FHashCount;
    property Size: Integer read HashSize;
    property Value[const Key: Variant]: Variant read GetValue
                                                write SetValue;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function HashFunc(Key: Variant): Integer; virtual; abstract;
    procedure AddItem(Key, Value: Variant);
    procedure RemoveItem(Key: Variant);
    procedure Clear;
    function KeyExists(Key: Variant): Boolean;
    function BucketCountByIdx(const Idx: Integer): Integer;
    function BucketCountByKey(const Key: Variant): Integer;
  end;

  TStringKeyHashTable = class(TCustomHashTable)
  protected
    function HashSize: Integer; override;
  public
    function HashFunc(Key: Variant): Integer; override;
    property Count;
    property Size;
    property Value; default;
  end;

implementation

const
  HashErrMsgs: array[THashErrMsg] of String =
    (
     'Hash key not found',
     'Hash key already exists',
     'Bucket index out of bounds'
    );
(*
 * TCustomHashTable
 *)

constructor TCustomHashTable.Create;
begin
  FItems := nil;
  FHashCount := 0;
  GetMem(FHash, Size * SizeOf(TBucket));
  // Ensure that the buckets are zero-initialized.
  FillChar(PChar(FHash)^, Size * SizeOf(TBucket), #0);
end;

destructor TCustomHashTable.Destroy;
begin
  Clear;
end;

function TCustomHashTable.FindItem(const Key: Variant;
  bQuiet: Boolean; HashVal: Integer): THashItem;
begin
  result := nil;
  if HashVal < 0 then
    HashVal := HashFunc(Key);
  if (HashVal < 0) then begin
    if (not bQuiet) then
      HashError(hKeyNotFound);
  end else begin
    result := FHash[HashVal].FirstItem;
    while (result <> nil) and (result.Key <> Key) do result := result.FBucketNext;
    if (result = nil) and (not bQuiet) then HashError(hKeyNotFound);
  end;
end;

procedure TCustomHashTable.HashError(const ErrMsg: THashErrMsg);
begin
  raise EHashError.Create(HashErrMsgs[ErrMsg]);
end;

function TCustomHashTable.GetValue(const Key: Variant): Variant;
begin
  result := FindItem(Key, False, -1).Value;
end;

procedure TCustomHashTable.SetValue(const Key: Variant; Value: Variant);
var
  p: THashItem;
begin
  p := FindItem(Key, True, -1);
  if p <> nil then
    p.Value := Value
  else
    AddItem(Key, Value);
end;

procedure TCustomHashTable.AddItem(Key, Value: Variant);
var
  i: Integer;
  hi: THashItem;
begin
  i := HashFunc(Key);
  if FindItem(Key, True, i) <> nil then
    HashError(hKeyExists);
  hi := THashItem.Create;
  hi.FKey := Key;
  hi.FValue := Value;
  hi.FHashIndex := i;
  // Insert hi at the beginning of the items list
  if (FItems <> nil) then
    FItems.FPrev := hi;
  hi.FNext := FItems;
  FItems := hi;
  // Insert hi at the beginning of its hash bucket
  if (FHash[hi.FHashIndex].FirstItem <> nil) then
    FHash[hi.FHashIndex].FirstItem.FBucketPrev := hi;
  hi.FBucketNext := FHash[hi.FHashIndex].FirstItem;
  FHash[hi.FHashIndex].FirstItem := hi;
  Inc(FHashCount);
  Inc(FHash[hi.FHashIndex].Count);
end;

procedure TCustomHashTable.RemoveItem(Key: Variant);
var
  hi: THashItem;
begin
  hi := FindItem(Key, False, -1);
  // Remove hi from the items list
  if (hi.FNext <> nil) then
    hi.FNext.FPrev := hi.FPrev;
  if (hi.FPrev <> nil) then
    hi.FPrev.FNext := hi.FNext
  else
    FItems := hi.FNext;
  // Remove hi from its hash bucket
  if (hi.FBucketNext <> nil) then
    hi.FBucketNext.FBucketPrev := hi.FBucketPrev;
  if (hi.FBucketPrev <> nil) then
    hi.FBucketPrev.FBucketNext := hi.FBucketNext
  else
    FHash[hi.FHashIndex].FirstItem := hi.FBucketNext;
  Dec(FHashCount);
  Dec(FHash[hi.FHashIndex].Count);
  // Finally, free hi from memory
  hi.Free;
end;

procedure TCustomHashTable.Clear;
var
  p: THashItem;
begin
  FHashCount := 0;
  FillChar(PChar(FHash)^, Size * SizeOf(TBucket), 0);
  (*
   * Walk FItems and destroy all items.
   *)
  p := FItems;
  while (p <> nil) do begin
    FItems := FItems.FNext;
    p.Free;
    p := FItems;
  end;
end;

function TCustomHashTable.KeyExists(Key: Variant): Boolean;
begin
  result := (FindItem(Key, True, -1) <> nil);
end;

function TCustomHashTable.BucketCountByIdx(const Idx: Integer): Integer;
begin
  if (Idx < 0) or (Idx >= Size) then
    HashError(hIndexOutOfBounds);
  result := FHash[Idx].Count;
end;

function TCustomHashTable.BucketCountByKey(const Key: Variant): Integer;
begin
  result := FHash[HashFunc(Key)].Count;
end;


(*
 * TStringKeyHashTable
 *)

function TStringKeyHashTable.HashSize: Integer;
begin
  result := 256;
end;

function TStringKeyHashTable.HashFunc(Key: Variant): Integer;
var
  st: String;
  i: Integer;
begin
  st := Key;
  result := 0;
  for i := 1 to Length(st) do Inc(result, Integer(st[i]));
  result := result mod Size;
end;

end.
 