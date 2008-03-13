function ebsd = loadEBSD(fname,varargin)
% import ebsd data 
%
%% Description
% *loadEBSD* is a high level method for importing EBSD data from external
% files. It autodetects the format of the file. As parameters the method
% requires a filename and the crystal and specimen @symmetry. Furthermore,
% you can specify a comment to be associated with the data. In the case of
% generic ascii files each of which consist of a table containing in each
% row the euler angles of a certain orientation see
% [[loadEBSD_txt.html,loadEBSD_txt]] for additional options.
%
%% Syntax
%  pf = loadEBSD(fname,cs,ss,<options>)
%
%% Input
%  fname     - filename
%  cs, ss    - crystal, specimen @symmetry (optional)
%
%% Options
%  interface  - specific interface to be used
%  comment    - comment to be associated with the data
%
%% Output
%  ebsd - @EBSD
%
%% See also
% interfacesEBSD_index ebsd/calcODF ebsd_demo loadEBSD_txt

%% proceed input argument

if ischar(fname), fname = {fname};end

% get crystal and specimen symmetry
if ~isempty(varargin) && isa(varargin{1},'symmetry')
  cs = varargin{1};varargin = {varargin{2:end}};
end

if ~isempty(varargin) && isa(varargin{1},'symmetry')
  ss = varargin{1};varargin = {varargin{2:end}};
end

%% determine interface
interface = get_option(varargin,'interface',check_ebsd_interfaces(fname{1},varargin{:}));

% txt interface does not fit are format that is already fitted by another
% interface
if length(interface)==2 && ~isempty(strcmp(interface,'txt'))
  interface(strcmp(interface,'txt')) = [];

elseif iscell(interface) && length(interface)>=2  % if there are multiple interfaces
 i = listdlg('PromptString',...
   'There is more then one interface matching your data. Select one!',...
   'SelectionMode','single',...
   'ListSize',[400 100],...
   'ListString',interface);
 interface = interface(i);
end

if isempty(interface)
  if exist(fname{1},'file')
    error('File %s does not match any supported interface.',fname{1});
  else
    error('File %s not found.',fname{1});
  end
end

%% import data

ebsd = [];
for i = 1:length(fname)  
  ebsd = [ebsd,feval(['loadEBSD_',char(interface)],fname{i},varargin{:})]; 
end

for i = 1:length(ebsd)
  if exist('cs','var'), ebsd(i) = set(ebsd(i),'CS',cs);end
  if exist('ss','var'), ebsd(i) = set(ebsd(i),'SS',ss);end
 
  [ps,fn,ext] = fileparts([fname{min(i,length(fname))}]);
  ebsd(i) = set(ebsd(i),'comment',get_option(varargin,'comment',[fn ext]));
  
end