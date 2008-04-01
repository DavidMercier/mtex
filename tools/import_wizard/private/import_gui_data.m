function handles = import_gui_data( handles, varargin )

pos = get(handles.wzrd,'Position');
h = pos(4);
w = pos(3);

ph = 270;

type = get_option(varargin,'type');


%% first page.
handles.page1 = get_panel(w,h,ph);

handles.listbox = uicontrol(...
'Parent',handles.page1,...
'BackgroundColor',[1 1 1],...
'FontName','monospaced',...
'HorizontalAlignment','left',...
'Max',2,...
'Position',[10 10 250 ph-20],...
'String',blanks(0),...
'Style','listbox',...
'Value',1);


handles.add = uicontrol(...
  'Parent',handles.page1,...
  'String','Add File',...
   'Callback',['import_wizard_' type '(''addData'')'],...
  'Position',[270 ph-35 110 25]);
handles.del = uicontrol(...
  'Parent',handles.page1,...
  'String','Remove File',...
  'CallBack',['import_wizard_' type '(''delData'')'],...
  'Position',[270 ph-65 110 25]);
