unit in0k_lazarusIdeSRC__TMPLT_4SourceWindow;

{$mode objfpc}{$H+}

interface

{$include in0k_LazarusIdeSRC__Settings.inc}

uses {$ifDef in0k_LazarusIdeEXT__DEBUG}in0k_lazarusIdeSRC__wndDEBUG,{$endIf}
  in0k_lazarusIdeSRC__expertCORE,
  //-------
  SrcEditorIntf;

type

 tIn0k_lazIdeSRC__TMPLT_4SourceWindow=class(tIn0k_lazIdeSRC_expertCORE)
  protected
    procedure _wrkEvent_(const sender:tObject); virtual;
  protected //< события IDE провацируещие наше ОСНОВНОЕ
    procedure _ideEvent_semWindowFocused_(sender:tObject);
  protected
    procedure LazarusIDE_SetUP; override;
    procedure LazarusIDE_CLEAN; override;
  public
    constructor Create;
    destructor DESTROY; override;
  end;

implementation {%region --- возня с ДЕБАГОМ (включить/выключить) -- /fold}
{$define DEBUG_ON} //< ВКЛЮЧИТЬ ЛОКАЛЬНЫЙ `DEBUG` режим
{$if declared(in0k_lazarusIdeSRC_DEBUG)}
    // `in0k_lazarusIdeSRC_DEBUG` - это функция ИНДИКАТОР что используется
    //                              моя "система"
    {$define _debugLOG_} //< и типа да ... можно делать ДЕБАГ отметки
{$endIf}
{$ifnDEF DEBUG_ON}
    {$unDef _debugLOG_}
{$endIf}
{%endregion}

constructor tIn0k_lazIdeSRC__TMPLT_4SourceWindow.Create;
begin
    inherited;
end;

destructor tIn0k_lazIdeSRC__TMPLT_4SourceWindow.DESTROY;
begin
    inherited;
end;

//------------------------------------------------------------------------------

// окно `SourceWindow` активируется самой IDE
//-----
// Происходит:
//   - СОЗДАНИЕ нового окна
//   - ПЕРЕХОД между уже созданными
procedure tIn0k_lazIdeSRC__TMPLT_4SourceWindow._ideEvent_semWindowFocused_(sender:tObject);
begin
    {$ifDef _debugLOG_}
    if Assigned(sender)
    then DEBUG(self.ClassName+'._ideEvent_semWindowFocused_', 'sender:'+sender.ClassName+addr2txt(Sender))
    else DEBUG(self.ClassName+'._ideEvent_semWindowFocused_', 'sender:NIL');
    {$endIf}
   _wrkEvent_(sender);
end;

//------------------------------------------------------------------------------

procedure tIn0k_lazIdeSRC__TMPLT_4SourceWindow._wrkEvent_(const sender:tObject);
begin
    {$ifDef _debugLOG_}
    if Assigned(sender)
    then DEBUG(self.ClassName+'._wrkEvent_', 'sender:'+sender.ClassName+addr2txt(Sender))
    else DEBUG(self.ClassName+'._wrkEvent_', 'sender:NIL');
    {$endIf}
end;

//------------------------------------------------------------------------------

procedure tIn0k_lazIdeSRC__TMPLT_4SourceWindow.LazarusIDE_SetUP;
begin
    inherited;
    SourceEditorManagerIntf.RegisterChangeEvent(semWindowFocused,  @_ideEvent_semWindowFocused_);
end;

procedure tIn0k_lazIdeSRC__TMPLT_4SourceWindow.LazarusIDE_CLEAN;
begin
    inherited;
    SourceEditorManagerIntf.UnRegisterChangeEvent(semWindowFocused,@_ideEvent_semWindowFocused_);
end;

end.
