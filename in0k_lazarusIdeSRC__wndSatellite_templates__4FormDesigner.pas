unit in0k_lazarusIdeSRC__wndSatellite_templates__4FormDesigner;

{$mode objfpc}{$H+}

interface

{$include in0k_LazarusIdeSRC__Settings.inc}

uses {$ifDef in0k_LazarusIdeEXT__DEBUG}in0k_lazarusIdeSRC__wndDEBUG,{$endIf}
  in0k_lazarusIdeSRC__expertCORE,
  in0k_lazarusIdeSRC__fuckUp_onActivate,
  //-------
  FormEditingIntf,
  PropEdits,
  //---
  Forms;

type

 tIn0k_LazIdeEXT__wndStllte_TMPLTs_4FormDesigner=class(tIn0k_lazIdeSRC_expertCORE)
  protected
   _fuckUp_onActivate_:tIn0k_lazarusIdeSRC__fuckUp_onActivate;
 protected //< ОСНОВНОЕ событие, все ради него и затевается
    procedure _wrkEvent_; virtual;
 protected //< события IDE провацируещие наше ОСНОВНОЕ
    procedure _ideEvent_selfFormActivate_({%H-}sender:tObject);
    procedure _ideEvent_ChangeLookupRoot_;
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

constructor tIn0k_LazIdeEXT__wndStllte_TMPLTs_4FormDesigner.Create;
begin
    inherited;
   _fuckUp_onActivate_:=tIn0k_lazarusIdeSRC__fuckUp_onActivate.Create;
   _fuckUp_onActivate_.onActivate:=@_ideEvent_selfFormActivate_;
end;

destructor tIn0k_LazIdeEXT__wndStllte_TMPLTs_4FormDesigner.DESTROY;
begin
   _fuckUp_onActivate_.FREE;
    inherited;
end;

//------------------------------------------------------------------------------

// окно `DesignerForm` активируется самой IDE
//-----
// Происходит:
//   - СОЗДАНИЕ нового окна
//   - ПЕРЕХОД между уже созданными
procedure tIn0k_LazIdeEXT__wndStllte_TMPLTs_4FormDesigner._ideEvent_ChangeLookupRoot_;
var sender:TCustomForm;
begin
    if Assigned(GlobalDesignHook.LookupRoot) then begin
        sender:=FormEditingHook.GetDesignerForm(GlobalDesignHook.LookupRoot);
        if Assigned(sender) then begin
          _fuckUp_onActivate_.FuckUP_reSet(sender);
				end;
		end;
    {$ifDef _debugLOG_}
    DEBUG('_ideEvent_ChangeLookupRoot_', 'targetWND'+addr2txt(sender));
    {$endIf}
   _wrkEvent_;
end;

// окно `DesignerForm` САМО активировалося
//-----
// Происходит:
//   - ВОЗВРАЩЕНИЕ "фокуса" в окно, которое УЖЕ ранее было в _ideEvent_ChangeLookupRoot_
procedure tIn0k_LazIdeEXT__wndStllte_TMPLTs_4FormDesigner._ideEvent_selfFormActivate_(sender:tObject);
begin
    {$ifDef _debugLOG_}
    DEBUG('_ideEvent_selfFormActivate_', 'targetWND'+addr2txt(Sender));
    {$endIf}
   _wrkEvent_;
end;

//------------------------------------------------------------------------------

procedure tIn0k_LazIdeEXT__wndStllte_TMPLTs_4FormDesigner._wrkEvent_;
begin
    {$ifDef _debugLOG_}
    DEBUG(self.ClassName,'_wrkEvent_');
    {$endIf}
end;

//------------------------------------------------------------------------------

procedure tIn0k_LazIdeEXT__wndStllte_TMPLTs_4FormDesigner.LazarusIDE_SetUP;
begin
    inherited;
    GlobalDesignHook.AddHandlerChangeLookupRoot(@_ideEvent_ChangeLookupRoot_);
end;

procedure tIn0k_LazIdeEXT__wndStllte_TMPLTs_4FormDesigner.LazarusIDE_CLEAN;
begin
    inherited;
    GlobalDesignHook.RemoveHandlerChangeLookupRoot(@_ideEvent_ChangeLookupRoot_);
end;

end.

