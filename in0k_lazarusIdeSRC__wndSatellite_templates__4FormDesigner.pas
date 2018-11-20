unit in0k_lazarusIdeSRC__wndSatellite_templates__4FormDesigner;

{$mode objfpc}{$H+}

interface

{$include in0k_LazarusIdeSRC__Settings.inc}

uses {$ifDef in0k_LazarusIdeEXT__DEBUG}in0k_lazarusIdeSRC__wndDEBUG,{$endIf}
  in0k_lazarusIdeSRC__expertCORE,
  in0k_lazarusIdeSRC__fuckUp_onActivate,
  //-------
  FormEditingIntf, Dialogs,
  PropEdits,
  //---
  Forms;

type

 tIn0k_LazIdeEXT__wndStllte_TMPLTs_4FormDesigner=class(tIn0k_lazIdeSRC_expertCORE)
  protected
   _fuckUp_onActivate_:tIn0k_lazarusIdeSRC__fuckUp_onActivate;
  protected //< ОСНОВНОЕ событие, все ради него и затевается
   _lastActivated_:TCustomForm;
    procedure _do_Event_(const sender:TCustomForm); {$ifOpt D-}inline;{$endIf}
    procedure _wrkEvent_; virtual;
  protected //< события IDE и окон
    procedure _ideEvent_selfFormActivate_({%H-}sender:tObject);
    procedure _ideEvent_selfFormDeActvte_({%H-}sender:tObject);
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
   _lastActivated_:=NIL;
   _fuckUp_onActivate_:=tIn0k_lazarusIdeSRC__fuckUp_onActivate.Create;
   _fuckUp_onActivate_.onActivate  :=@_ideEvent_selfFormActivate_;
   _fuckUp_onActivate_.onDeActvte:=@_ideEvent_selfFormDeActvte_;
end;

destructor tIn0k_LazIdeEXT__wndStllte_TMPLTs_4FormDesigner.DESTROY;
begin
    inherited;
   _fuckUp_onActivate_.FREE;
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
    sender:=nil;
    // ищем что-же за окно АКТИВИРОВАЛОСЯ
    if Assigned(GlobalDesignHook.LookupRoot) then begin
        sender:=FormEditingHook.GetDesignerForm(GlobalDesignHook.LookupRoot);
    end;
    //
    if Assigned(sender) then begin
        {$ifDef _debugLOG_}
        DEBUG(self.ClassName+'._ideEvent_ChangeLookupRoot_','sender('+sender.ClassName+')'+addr2txt(Sender));
        {$endIf}
        // возможно это окно у нас ВПЕРВЫЕ, попробуем подменить его события
       _fuckUp_onActivate_.Appaly4Control(sender);
        // выполняем наше ОСНОВНОЕ функциональное событие
       _do_Event_(sender);
    end
    {$ifDef _debugLOG_}
    else begin
        DEBUG(self.ClassName+'._ideEvent_ChangeLookupRoot_','sender(NIL) => SKIP');
    end
    {$endIf};
end;

// окно `DesignerForm` САМО активировалося
//-----
// Происходит:
//   - ВОЗВРАЩЕНИЕ "фокуса" в окно, которое УЖЕ ранее было в _ideEvent_ChangeLookupRoot_
procedure tIn0k_LazIdeEXT__wndStllte_TMPLTs_4FormDesigner._ideEvent_selfFormActivate_(sender:tObject);
begin
    if Assigned(sender) and (sender is TCustomForm)then begin
        {$ifDef _debugLOG_}
        DEBUG(self.ClassName+'._ideEvent_selfFormActivate_','sender('+sender.ClassName+')'+addr2txt(Sender));
        {$endIf}
        // выполняем наше ОСНОВНОЕ функциональное событие
       _do_Event_(TCustomForm(sender));
    end
    {$ifDef _debugLOG_}
    else begin
        if Assigned(sender)
        then DEBUG(self.ClassName+'._ideEvent_selfFormActivate_','sender('+sender.ClassName+')'+addr2txt(Sender)+' is NOT TCustomForm => SKIP')
        else DEBUG(self.ClassName+'._ideEvent_selfFormActivate_','sender(NIL) => SKIP');
    end
    {$endIf};
end;

// окно `DesignerForm` ДеАктивировано
//-----
// Происходит:
//   - "фокус" покинул окно
procedure tIn0k_LazIdeEXT__wndStllte_TMPLTs_4FormDesigner._ideEvent_selfFormDeActvte_({%H-}sender:tObject);
begin
    {$ifDef _debugLOG_}
    if Assigned(sender) then begin
        DEBUG(self.ClassName+'._ideEvent_selfFormDeActvte_','sender('+sender.ClassName+')'+addr2txt(Sender));
    end
    else begin
        DEBUG(self.ClassName+'._ideEvent_selfFormDeActvte_','sender(NIL) => ????');
    end
    {$endIf};
   _lastActivated_:=NIL; //< отметим что теперь ОПЯТЬ можно реагироваит на ОСНОВНОЕ событие
end;

//------------------------------------------------------------------------------

// выполнить ОСНОВЕНОЕ событие пользователя
// так как происходить "ДУБЛИРОВАНИЕ" событий ... пользуем _lastActivated_
procedure tIn0k_LazIdeEXT__wndStllte_TMPLTs_4FormDesigner._do_Event_(const sender:TCustomForm);
begin
    if Assigned(sender) and (_lastActivated_<>sender) then begin
       _lastActivated_:=sender;
       _wrkEvent_; //< наконец, дошли до вызова ОСНОВНОГО события
    end;
end;

// ПОЛЬЗОВАТЕЛЬСНОЕ основное событие.
//-----
// Происходит:
//   - Окно СТАЛО АКТИВНЫМ
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
    GlobalDesignHook.RemoveHandlerChangeLookupRoot(@_ideEvent_ChangeLookupRoot_);
    inherited;
end;

end.

