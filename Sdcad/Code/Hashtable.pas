//网上找到的delphi hashtable, delphi7下通过测试，其它版本没有测试，弄到这只是因为，代码可以研究。
// 我看过了的都加了点注释，后面没看了。
//
//Java 中的 Hashtable 类小巧好用，尤其是因为采用了哈希算法，查找的速度奇快。后来因
//工作需要，使用 Delphi 实施一些项目，特别不习惯没有哈希表的日子。于是决定自己动手做
//一个。
//不必白手起家，Delphi 中有一个 THashedStringList 类，它位于 IniFiles 单元中。它里面
//有一个不错的哈希算法，解决冲突的机制是“链地址”。把这个类改装改装，就成了自己的
//了。新鲜热辣，火爆出炉。下面就来看看新的 Hashtable 长得何许模样。

//使用起来就简单了：
//HashTable := THashTable.Create(); //创建
//HashTable.Put(Key, Value);       //赋值
//Value=HashTable.Get(Key);       //取值
//HashTable.Destroy;           //撤消
unit Hashtable;
 
    interface
 
    uses SysUtils, Classes;
 
    type
      { THashTable }
 
      PPHashItem = ^PHashItem;               //指向指针的指针，这个暂不明白
      PHashItem = ^THashItem;                 //这是下面定义的记录（结构体）的指针
      THashItem = record                          //这定义了一个记录（结构体）
      Next: PHashItem;
      Key: string;
      Value: String;
      end;                                              //看完这个结构，让我想起了单链表了
 
      THashTable = class                          //开始定义类了
      private
      Buckets: array of PHashItem;                           //一个指针数组
      protected
      function Find(const Key: string): PPHashItem; //通过string，返回指向记录体的指针
      function HashOf(const Key: string): Cardinal; virtual;//Cardinal不知道接触delphi时间还不长，virtual应该是申明此函数为虚函数吧
      public
      constructor Create(Size: Integer = 256);
      destructor Destroy; override;
      procedure Put(const Key: string; Value: String);
      procedure Clear;
      procedure Remove(const Key: string);
      function Modify(const Key: string; Value: String): Boolean;
      function Get(const Key: string): String;
      end;
 
    implementation
 
    { THashTable }
 
    procedure THashTable.Put(const Key: string; Value: String);
    var
      Hash: Integer;
      Bucket: PHashItem;
    begin
      Hash := HashOf(Key) mod Cardinal(Length(Buckets));   //计算hash值
      New(Bucket);                                                          //新建一个节点
      Bucket^.Key := Key;
      Bucket^.Value := Value;
      Bucket^.Next := Buckets[Hash];//这个指针貌视指到了自己，是我看错了？
      Buckets[Hash] := Bucket;                   // 将节点指针存入到数组，根据hash值
    end;
 
    procedure THashTable.Clear;       //很明显，循环释放空间，清空数组
    var                                      
      I: Integer;
      P, N: PHashItem;
    begin
      for I := 0 to Length(Buckets) - 1 do
      begin
      P := Buckets[I];
      while P <> nil do
      begin
        N := P^.Next;
        Dispose(P);
        P := N;
      end;
      Buckets[I] := nil;
      end;
    end;
 
   constructor THashTable.Create(Size: Integer);//初始化hashtable即那个指针数组
    begin
      inherited Create;
      SetLength(Buckets, Size); 
    end;
 
    destructor THashTable.Destroy;
    begin
      Clear;
      inherited;
    end;
 
    function THashTable.Find(const Key: string): PPHashItem;
    var
      Hash: Integer;
    begin
      Hash := HashOf(Key) mod Cardinal(Length(Buckets));
      Result := @Buckets[Hash];
      while Result^ <> nil do
      begin
      if Result^.Key = Key then
        Exit
      else
        Result := @Result^.Next;
      end;
    end;
 
    function THashTable.HashOf(const Key: string): Cardinal;
    var
      I: Integer;
    begin
      Result := 0;
      for I := 1 to Length(Key) do
      Result := ((Result shl 2) or (Result shr (SizeOf(Result) * 8 - 2))) xor
        Ord(Key[I]);
    end;
 
    function THashTable.Modify(const Key: string; Value: String): Boolean;
    var
      P: PHashItem;
    begin
      P := Find(Key)^;
      if P <> nil then
      begin
      Result := True;
      P^.Value := Value;
      end
      else
      Result := False;
    end;
 
    procedure THashTable.Remove(const Key: string);
    var
      P: PHashItem;
      Prev: PPHashItem;
    begin
      Prev := Find(Key);
      P := Prev^;
      if P <> nil then
      begin
      Prev^ := P^.Next;
      Dispose(P);
      end;
    end;
 
    function THashTable.Get(const Key: string): String;
    var
      P: PHashItem;
    begin
      P := Find(Key)^;
      if P <> nil then
      Result := P^.Value else
      Result := '';
    end;
 
    end.
