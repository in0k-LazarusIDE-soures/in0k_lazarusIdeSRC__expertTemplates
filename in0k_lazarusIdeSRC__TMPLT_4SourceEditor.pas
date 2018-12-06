unit in0k_lazarusIdeSRC__TMPLT_4SourceEditor;

{$mode objfpc}{$H+}

interface

{$include in0k_LazarusIdeSRC__Settings.inc}

uses {$ifDef in0k_LazarusIdeEXT__DEBUG}in0k_lazarusIdeSRC__wndDEBUG,{$endIf}
  in0k_lazarusIdeSRC__expertCORE,
  //-------
  SrcEditorIntf;

type

 tIn0k_lazIdeSRC__TMPLT_4SourceEditor=class(tIn0k_lazIdeSRC_expertCORE)
  protected
    //procedure _wrkEvent_; virtual;
  protected //< события IDE провацируещие наше ОСНОВНОЕ
    procedure _ideEvent_semEditorActivate_(sender:tObject);
  protected
    procedure LazarusIDE_SetUP; override;
    procedure LazarusIDE_CLEAN; override;
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

procedure tIn0k_lazIdeSRC__TMPLT_4SourceEditor._ideEvent_semEditorActivate_(sender:tObject);
begin
    {$ifDef _debugLOG_}
    if Assigned(sender)
    then DEBUG(self.ClassName+'._ideEvent_semEditorActivate_', 'sender:'+sender.ClassName+addr2txt(Sender))
    else DEBUG(self.ClassName+'._ideEvent_semEditorActivate_', 'sender:NIL');
    {$endIf}
end;

//------------------------------------------------------------------------------

procedure tIn0k_lazIdeSRC__TMPLT_4SourceEditor.LazarusIDE_SetUP;
begin
    inherited;
    SourceEditorManagerIntf.RegisterChangeEvent(semEditorActivate,@_ideEvent_semEditorActivate_);
end;

procedure tIn0k_lazIdeSRC__TMPLT_4SourceEditor.LazarusIDE_CLEAN;
begin
    SourceEditorManagerIntf.UnRegisterChangeEvent(semEditorActivate,@_ideEvent_semEditorActivate_);
    inherited;
end;

//------------------------------------------------------------------------------

end.

