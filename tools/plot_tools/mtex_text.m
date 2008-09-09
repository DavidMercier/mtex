function mtex_text(x,y,t,varargin)
% insert text depending on mtex_options

if isa(t,'Miller') || isa(t,'vector3d')
  for i = 1:length(t)
    if check_mtex_option('noLaTex')
      s{i} = char(t,'Tex');
    else
      s{i} = ['$' char(t(i),'LaTex') '$'];
    end
  end
else
  if ~ischar(t)
    s = char(t);
  else
    s = t;
  end
  if ~check_mtex_option('noLaTex')
    s = ['$' s '$'];
  end
end
if check_mtex_option('noLaTex')
  optiondraw(text(x,y,s,'interpreter','tex'),varargin{:});
elseif ~isempty(t)
  optiondraw(text(x,y,s,'interpreter','latex'),varargin{:});
end