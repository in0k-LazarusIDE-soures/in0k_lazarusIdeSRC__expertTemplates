unit in0k_lazarusIdeSRC__wndSatellite_templates__4SourceWindow;

{$mode objfpc}{$H+}

interface

{$include in0k_LazarusIdeSRC__Settings.inc}

uses {$ifDef in0k_LazarusIdeEXT__DEBUG}in0k_lazarusIdeSRC__wndDEBUG,{$endIf}
  in0k_lazarusIdeSRC__expertCORE,
  //-------
  SrcEditorIntf;

type

 tIn0k_LazIdeEXT__wndStllte_TMPLTs_4SourceWindow=class(tIn0k_lazIdeSRC_expertCORE)
  protected
    procedure _wrkEvent_; virtual;
  protected //< события IDE провацируещие наше ОСНОВНОЕ
    procedure _ideEvent_semWindowFocused_(sender:tObject);
  protected
    procedure LazarusIDE_SetUP; override;
    procedure LazarusIDE_CLEAN; override;
  public
    constructor Create;
    destructor DESTROY; override;
  end;

implementation
{%region --- возня с ДЕБАГОМ -------------------------------------- /fold}
{$if declared(in0k_lazarusIdeSRC_DEBUG)}
    // `in0k_lazarusIdeSRC_DEBUG` - это функция ИНДИКАТОР что используется
    //                              моя "система"
    {$define _debugLOG_} //< и типа да ... можно делать ДЕБАГ отметки
{$endIf}
{%endregion}

constructor tIn0k_LazIdeEXT__wndStllte_TMPLTs_4SourceWindow.Create;
begin
    inherited;
end;

destructor tIn0k_LazIdeEXT__wndStllte_TMPLTs_4SourceWindow.DESTROY;
begin
    inherited;
end;

//------------------------------------------------------------------------------

// окно `SourceWindow` активируется самой IDE
//-----
// Происходит:
//   - СОЗДАНИЕ нового окна
//   - ПЕРЕХОД между уже созданными
procedure tIn0k_LazIdeEXT__wndStllte_TMPLTs_4SourceWindow._ideEvent_semWindowFocused_(sender:tObject);
begin
    {$ifDef _debugLOG_}
    DEBUG('_ideEvent_semWindowFocused_', 'targetWND'+addr2txt(Sender));
    {$endIf}
   _wrkEvent_;
end;

//------------------------------------------------------------------------------

procedure tIn0k_LazIdeEXT__wndStllte_TMPLTs_4SourceWindow._wrkEvent_;
begin
    {$ifDef _debugLOG_}
    DEBUG(self.ClassName,'_wrkEvent_');
    {$endIf}
end;

//------------------------------------------------------------------------------

procedure tIn0k_LazIdeEXT__wndStllte_TMPLTs_4SourceWindow.LazarusIDE_SetUP;
begin
    inherited;
    SourceEditorManagerIntf.RegisterChangeEvent(semWindowFocused,  @_ideEvent_semWindowFocused_);
end;

procedure tIn0k_LazIdeEXT__wndStllte_TMPLTs_4SourceWindow.LazarusIDE_CLEAN;
begin
    inherited;
    SourceEditorManagerIntf.UnRegisterChangeEvent(semWindowFocused,@_ideEvent_semWindowFocused_);
end;

end.
